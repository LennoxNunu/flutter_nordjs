const mongoose = require('mongoose');

const Note = require('../models/note');

exports.notes_post_singleNote = (req, res, next) => {
  
    const note = new Note({
       _id: new mongoose.Types.ObjectId(),
       title : req.body.title,
       description : req.body.description,
       email : req.body.email
    });
    note
       .save()
       .then(result => { console.log(result); res.status(201).json({ message: "Handling Post Resquest TO /Notes", createdProduct: result }); })
       .catch(err => { console.log(err); res.status(500).json({ error: err }); });
 }


 exports.notes_get_allOfSingleUser = (req, res, next) => {
    const emailUser = req.params.userEmail;
    Note.find({email: emailUser})
       .exec()
       .then(docs => { console.log(docs); res.status(200).json(docs); })
       .catch(
          err => {
             console.log(err);
             res.status(500).json({ error: err });
          }
       );
 }

 exports.notes_patch_singleNote = (req, res, next) => {
    const id = req.params.userId;
    const updateOps = {};

    for (const ops of req.body) {
       updateOps[ops.propTitle] = ops.value;

    }

    Note.update({ _id: id }, { $set: updateOps })
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

 exports.notes_delete_singleNote = (req, res, next) => {
    const id = req.params.userId;
    Note.remove({ _id: id})
       .exec()
       .then(result => { res.status(200).json(result); })
       .catch(err => {
          console.log(err);
          res.status(500).json({ error: err });
       }
       );
 }
