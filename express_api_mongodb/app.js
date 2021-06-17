const express = require('express');

const app = express();

const morgan = require('morgan');

const bodyParser = require('body-parser');

const mongoose = require('mongoose');

const notesRoute = require('./api/routes/notes');

const userRoute = require('./api/routes/user');

mongoose.connect('mongodb+srv://Smith:'+ process.env.MONGO_ATLAS_PW +'@apiflutter.g0tsr.mongodb.net/myFirstDatabase?retryWrites=true&w=majority',
{
useMongoClient: true
}
);    

mongoose.Promise = global.Promise;

app.use(morgan('dev'));

app.use(bodyParser.urlencoded({extended: false }));

app.use(bodyParser.json());

app.use(
(req,res,next)=>{
res.header('Access-Control-Allow-Origin','*');
res.header('Access-Control-Allow-Headers','Origin, X-Requested-With, Content-Type, Accept, Authorization');
if(req.method === 'OPTIONS'){
res.header('Access-Control-Allow-Methods', 'Put, Post, Patch, Delete,Get');
return res.status(200).json({});
}
next();  
}
);

app.use('/notes',notesRoute);

app.use('/user',userRoute);

app.use(
(req,res,next)=>{
const error = new Error('Not Found');
error.status = 404;
next(error)
   }
);

app.use(
(error,req,res,next) =>{
 res.status(error.status || 500);
 res.json(
 {error:{message :error.message}}
 );
}
);

module.exports = app;