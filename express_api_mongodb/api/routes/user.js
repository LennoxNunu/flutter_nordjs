const express = require('express');

const router = express.Router();

const UserController = require('../controllers/user');


router.post('/signup', UserController.user_post_signUp);

router.post("/login", UserController.user_post_login);

router.patch('/update/:userEmail', UserController.user_patch_updateUser);

router.delete('/delete/:userEmail', UserController.user_delete_deleteUser);


module.exports = router;