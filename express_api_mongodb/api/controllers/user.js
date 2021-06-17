const mongoose = require('mongoose');

const bcrypt = require('bcrypt');

const jwt = require('jsonwebtoken');

const User = require('../models/user');


exports.user_post_signUp = (req, res, next) => {
    User.find({ email: req.body.email })
        .exec()
        .then(user => {
            if (user) { res.status(422).json({ message: "Mail already exist" }); }
            else {
                bcrypt.hash(req.body.password, 10, (err, hash) => {

                    if (err) { return res.status(500).json({ error: err }); } else {
                        const user = new User({ _id: new mongoose.Types.ObjectId(), email: req.body.email, password: hash });


                        user.save()
                            .then(result => { console.log(result); res.status(201).json({ message: "User Created" }); })
                            .catch(err => { console.log(err); res.status(500).json({ error: err }); });

                    }

                })
            }
        });
}


exports.user_post_login = (req, res, next) => {
    User.find({ email: req.body.email })
        .exec()
        .then(user => {
            if (user.lenght < 1) { return res.status(404).json({ message: "Authentication Failed" }); }
            bcrypt.compare(req.body.password, user[0].password, (err, result) => {
                if (err) { return res.status(401).json({ message: "Authentication Failed" }); }
                if (result) {
                    const token = jwt.sign({ email: user[0].email, userId: user[0]._id },
                        process.env.JWT_KEY, { expiresIn: "1h" });
                    return res.status(201).json({ message: "Authentication Successful", token: token });
                }
                res.status(401).json({ message: "Authentication Failed" });
            })
        })
        .catch(err => { res.status(500).json({ error: err }); });
}

exports.user_patch_updateUser = (req, res, next) => {
    const usersEmail = req.params.usersEmail;
    const updateOps = {};

    for (const ops of req.body) {
        updateOps[ops.propTitle] = ops.value;

    }


    User.update({ email: usersEmail }, { $set: updateOps })
        .exec()
        .then(
            result => {
                console.log(result);
                res.status(200).json(result);
            })
        .catch(
            err => {
                console.log(err);
                res.status(500).json({ error: err });
            }
        );
}

exports.user_delete_deleteUser = (req, res, next) => {
    const userEmail = req.params.userEmail;
    Note.remove({ email : userEmail })
        .exec()
        .then(result => { res.status(200).json({ message: "User Deleted" }); })
        .catch(
            err => {
                console.log(err);
                res.status(500).json({ error: err });
            });
}