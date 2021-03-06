const express = require('express')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');
const { route } = require('./user');
const userAuthorization = require('../middlewares/userAuthorization');
const router = express.Router()
const mysql = require('../lib/mysql').pool

function getGroupName(req,res){
    const groupId = req.params.groupId;

    if(!groupId){
        return res.status(400).send({
            error: 'Missing group id.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT name FROM Group WHERE group_id = ? LIMIT 1;',
            [groupId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Group name retrieved.', data: results[0].name});
            }
        );
    });
}

function getGroupParticipants(req,res){
    const groupId = req.params.groupId;

    if(!groupId){
        return res.status(400).send({
            error: 'Missing group id.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT user_id FROM GroupParticipant INNER JOIN Group ON GroupParticipant.group_id = Group.group_id WHERE Group.group_id = ?;', 
            [groupId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Group participants retrieved.', data: results});
            }
        );
    });
}

//get group creation date
function getGroupCreationDate(req,res){
    const groupId = req.params.groupId;

    if(!groupId){
        return res.status(400).send({
            error: 'Missing group id.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT group_creation_date FROM Group WHERE group_id = ? LIMIT 1;',
            [groupId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Group creation date retrieved.', data: results[0].group_creation_date});
            }
        );
    });
}

//add user to group
function addUserToGroup(req,res){
    const groupId = req.body.groupId;
    const userId = req.body.userId;

    if(!groupId || !userId){
        return res.status(400).send({
            error: 'Missing group id or user id.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){ 
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'INSERT INTO GroupParticipant (group_id, user_id) VALUES (?, ?);',
            [groupId, userId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'User added to group.'});
            }
        );
    });
}

function getLastGroupMessage(req,res){
    const userId = req.params.userId;
    if(!userId){
        return res.status(400).send({
            error: 'Missing user id.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT message_body, time, sender_id, department_id from GroupMessage where department_id = (SELECT department_id From User where user_id = ?) ORDER BY time DESC LIMIT 1;',
            [userId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }
                if(results.length == 0){
                    return res.status(204).send({response: 'No messages found.'});
                }
                return res.status(200).send({response: 'Last message retrieved.', data: results[0]});
            }
        );
    });

}

function sendGroupMessage(req, res){
    const message = req.body.message;
    const senderId = req.body.senderId;
    const departmentId = req.body.departmentId;
    
    if(!message || !senderId || !departmentId){
        return res.status(400).send({
            error: 'Missing message or sender id.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'INSERT INTO GroupMessage (message_body, time, sender_id, department_id) VALUES (?, NOW(), ?, ?);',
            [message, senderId, departmentId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }
                return res.status(200).send({ response: results.insertId,});
            }
        );
    });
}


function getFirstTenGroupMessages(req, res){
    const departmentId = req.params.departmentId;
    if(!departmentId){
        return res.status(400).send({
            error: 'Missing department id.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT group_message_id, message_body, time, sender_id, User.department_id, User.name, Department.name as deptname from GroupMessage INNER JOIN User ON user_id = sender_id INNER JOIN Department ON Department.department_id = User.department_id where GroupMessage.department_id = ? ORDER BY time DESC LIMIT 10;',
            [departmentId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }
                if(results.length == 0){
                    return res.status(204).send({response: 'No messages found.'});
                }
                return res.status(200).send({response: 'First ten messages retrieved.', data: results});
            }
        );
    });
}

function getNextTenMessages(req, res){
    const departmentId = req.params.departmentId;
    const page = parseInt(req.body.page) * 10;
    if(!departmentId || typeof page === undefined){
        return res.status(400).send({
            error: 'Missing message id or page.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT group_message_id, message_body, time, sender_id,' +
             'User.department_id, User.name, Department.name as deptname ' +
             'from GroupMessage INNER JOIN User ON user_id = sender_id INNER ' +
              'JOIN Department ON Department.department_id = User.department_id ' +
               'where GroupMessage.department_id = ? ORDER BY time DESC LIMIT 10 OFFSET ?;',
            [departmentId, page],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }
                if(results.length == 0){
                    return res.status(204).send({response: 'No messages found.'});
                }
                return res.status(200).send({response: 'Next ten messages retrieved.', data: results});
            }
        );
    });
}


router.get('/name/:id', getGroupName);
router.get('/participants/:id', getGroupParticipants);
router.get('/creation_date/:id', getGroupCreationDate);
router.post('/add_user', addUserToGroup);
router.get('/last_message/:userId', userAuthorization, getLastGroupMessage);
router.post('/send_message', userAuthorization, sendGroupMessage);
router.get('/first_ten_messages/:departmentId',userAuthorization, getFirstTenGroupMessages);
router.post('/next_ten_messages/:departmentId', getNextTenMessages);

module.exports = router;