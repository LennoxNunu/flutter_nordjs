const express = require('express');

const router = express.Router();

const checkAuth = require('../middleware/check-auth');

const NotesController =require('../controllers/notes');


router.post('/', checkAuth, NotesController.notes_post_singleNote );
router.get('/:userEmail', checkAuth, NotesController.notes_get_allOfSingleUser);
router.patch('/update/:userId', checkAuth, NotesController.notes_patch_singleNote);
router.delete('/delete/:userId', checkAuth, NotesController.notes_delete_singleNote);

module.exports = router;