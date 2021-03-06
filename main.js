const express = require('express');
const app = express();
const path = require('path');
const cors = require('cors');
const morgan = require('morgan')



app.use(morgan('dev'))
app.use(express.urlencoded({extended: true}));
app.use(express.json());


//CORS Policy Middleware
app.use(cors());
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*')
    res.header(
        'Access-Control-Allow-Header', 
        'Content-Type',
        'Multipart/Form-Data',
        'Origin, X-Requested-With, Accept, Authorization'
        )
    res.header('Access-Control-Max-Age', '86400')
    if(req.method === 'OPTIONS'){
        res.header('Access-Control-Allow-Methods', 'GET', 'POST', 'PUT', 'DELETE')
        return res.status(200).send({});
    }
    next();
})


//Routes
const userRoute = require('./routes/user');
const departmentRoute = require('./routes/department')
const announcementRoute = require('./routes/announcement')
const messagesRoute = require('./routes/messages')
const scheduleRoute = require('./routes/schedule')
const companyRouter = require('./routes/company')
const groupRouter = require('./routes/group')

app.use('/user', userRoute);
app.use('/department', departmentRoute);
app.use('/announcement', announcementRoute);
app.use('/schedule', scheduleRoute);
app.use('/messages', messagesRoute);
app.use('/company', companyRouter);
app.use('/group', groupRouter);
//app.use('/uploads', express.static(path.join(__dirname, '/uploads')))

app.use((req, res, next) => {
    const erro = new Error('Not Found.');
    erro.status = 404;
    next(erro);
})

module.exports = app;
