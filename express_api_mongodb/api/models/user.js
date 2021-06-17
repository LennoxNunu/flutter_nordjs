const mongoose = require('mongoose');

const noteSchema = mongoose.Schema({
    _id : mongoose.Schema.Types.ObjectId,
    password: { type: String, required: true },
    email: { type: String, required: true, unique: true },
  
  //  match: /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
});

module.exports = mongoose.model('User', noteSchema);