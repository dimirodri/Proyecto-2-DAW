//Invoke express
const express = require('express');
const app = express();

//Setting urlencoded for capture the form data
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

//Invoke dotenv
const dotenv = require('dotenv');
dotenv.config({ path: './env/.env' });

//public dir
app.use('/resources', express.static('public'));
app.use('/resources', express.static(__dirname + '/public'));

//Template engine
app.set('view engine', 'ejs');

//Invoke bcrypt
const bcryptjs = require('bcryptjs');

//Session var
const session = require('express-session');
app.use(session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
}));

//Invoke BBDD module
const connection = require('./database/db');


//invoke page
const path = require('path');
const { url } = require('inspector');
const { render } = require('ejs');
let initial_path = path.join(__dirname, "/");


app.get('/login', (req, res) => {
    if (!req.session.loggedin) {
        res.render('login');
    } else {
        res.render('index', {
            alert: false,
            alertTitle: "",
            AlertMessage: "",
            alertIcon: '',
            showConfirmButton: false,
            timer: false,
            ruta: ''
        });
    }

})
app.get('/register', (req, res) => {
    if (!req.session.loggedin) {
        res.render('register');
    } else {
        res.render('index', {
            alert: false,
            alertTitle: "",
            AlertMessage: "",
            alertIcon: '',
            showConfirmButton: false,
            timer: false,
            ruta: ''
        });
    }

})


app.get('/record', (req, res) => {
    if (req.session.loggedin) {
        res.render('record', {
            login: true,
            name: 21
        });
    } else {
        res.render('record', {
            alert: true,
            alertTitle: "Inicio sesión",
            AlertMessage: "¡Incorrect login!",
            alertIcon: 'warning',
            showConfirmButton: true,
            timer: false,
            ruta: 'login'
        });
    }
})

//Register
app.post('/register', async (req, res) => {
    const name = req.body.name;
    const email = req.body.email;
    const address = req.body.address;
    const username = req.body.username;
    const password = req.body.password;
    const passwordrepeat = req.body.passwordrepeat;
    let passwordHash = await bcryptjs.hash(password, 8);

    connection.query('SELECT * FROM users WHERE username = ?', [username], async (error, results) => {
        if (results.length == 0) {
            if (password == passwordrepeat) {
                connection.query('INSERT INTO users SET ?', { name: name, email: email, address: address, username: username, password: passwordHash }, async (error, results) => {
                    if (error) {
                        res.render('register', {
                            alert: true,
                            alertTitle: "Registro",
                            AlertMessage: "Registro fallido",
                            alertIcon: 'error',
                            showConfirmButton: false,
                            timer: 2500,
                            ruta: 'register'
                        })
                    } else {
                        res.render('register', {
                            alert: true,
                            alertTitle: "Registro",
                            AlertMessage: "¡Registro realizado!",
                            alertIcon: 'success',
                            showConfirmButton: false,
                            timer: 2500,
                            ruta: 'login'
                        })
                    }
                })
            } else {
                res.render('register', {
                    alert: true,
                    alertTitle: "Registro",
                    AlertMessage: "Las contraseñas no coinciden",
                    alertIcon: 'error',
                    showConfirmButton: false,
                    timer: 2500,
                    ruta: 'register'
                })
            }
        } else {
            res.render('register', {
                alert: true,
                alertTitle: "Registro",
                AlertMessage: "Usuario ya registrado",
                alertIcon: 'error',
                showConfirmButton: false,
                timer: 2500,
                ruta: 'register'
            })
        }
    })

})


//Login
app.post('/auth', async (req, res) => {
    const user = req.body.username;
    const pass = req.body.password;
    let passwordHash = await bcryptjs.hash(pass, 8);

    if (user && pass) {
        connection.query('SELECT * FROM users WHERE username = ?', [user], async (error, results) => {
            if (results.length == 0 || !(await bcryptjs.compare(pass, results[0].password))) {

                res.render('login', {
                    alert: true,
                    alertTitle: "Inicio sesión",
                    AlertMessage: "¡Inicio de sesión incorrecto!",
                    alertIcon: 'warning',
                    showConfirmButton: true,
                    timer: 2000,
                    ruta: 'login'
                });
            } else {
                req.session.loggedin = true;
                req.session.name = results[0].name;
                req.session.userId = results[0].id;
                res.render('login', {
                    alert: true,
                    alertTitle: "Login",
                    AlertMessage: "¡Incorrect login!",
                    alertIcon: 'warning',
                    showConfirmButton: true,
                    timer: false,
                    ruta: ''
                })

            }
        });
    }
})

//comments
app.post('/note', async (req, res) => {
    if (req.session.loggedin) {
        var note = req.body.note;
        
        if (note.length != 0) {
            connection.query('INSERT INTO punctuate SET ?', { user_id: req.session.userId, film_id: req.session.filmId, note: note }, async (error, results) => {
                if (error) {
                    res.render('about', {
                        alert: true,
                        alertTitle: "Nota",
                        AlertMessage: "¡Algo ha salido mal!",
                        alertIcon: 'warning',
                        showConfirmButton: true,
                        timer: 2000,
                        ruta: req.session.filmId
                    });
                } else {
                    
                    res.render('about', {
                        alert: true,
                        alertTitle: "Nota",
                        AlertMessage: "¡Nota añadida correctamente!",
                        alertIcon: 'success',
                        showConfirmButton: true,
                        timer: 2000,
                        ruta: req.session.filmId
                    });
                }
            })
        }
    } else {
        res.render('index', {
            alert: true,
            alertTitle: "",
            AlertMessage: "",
            alertIcon: '',
            showConfirmButton: true,
            timer: false,
            ruta: ''
        });
    }
})

// Auth pages
app.get('/', (req, res) => {
    if (req.session.loggedin) {
        res.render('index', {
            login: true,
            name: req.session.name
        });
    } else {
        res.render('login', {
            alert: true,
            alertTitle: "Inicio sesión",
            AlertMessage: "¡Incorrect login!",
            alertIcon: 'warning',
            showConfirmButton: true,
            timer: false,
            ruta: 'login'
        });
    }
})

//record
app.get('/record', (req, res) => {
    console.log('hey')
    if (req.session.loggedin) {
        connection.query('SELECT film.name FROM users,record,film where users.id=record.user_id and record.film_id=film.id and record.user_id = ?', [req.session.userId], async (error, results) => {
            console.log('hola');
        })
        res.render('record', {
            login: true,
            name: 21
        });
    } else {
        res.render('record', {
            alert: true,
            alertTitle: "Inicio sesión",
            AlertMessage: "¡Incorrect login!",
            alertIcon: 'warning',
            showConfirmButton: true,
            timer: false,
            ruta: 'login'
        });
    }
})

//Logout
app.get('/login/logout', (req, res) => {
    req.session.destroy(() => {
        res.redirect('/login');
    })
});
app.get('/:id', (req, res) => {
    if (req.session.loggedin) {
        let fullUrl = req.originalUrl;
        let filmId = fullUrl.slice(1);
        req.session.filmId = filmId;

        const https = require('https')
        const url = `https://api.themoviedb.org/3/movie/${filmId}?api_key=6750e7dd2f3e564adbcabb079ab4d73f&language=es-ES`;
        var noteAVG=0;
        var sum=0;
        connection.query('SELECT note FROM punctuate WHERE film_id = ?', [filmId], async (error, results) => {
            if (results.length == 0) {
                noteAVG=0;
            }else{
                for (let index = 0; index < results.length; index++) {
                    sum +=results[index].note;
                    
                }
                noteAVG=sum/results.length;
                req.session.avg=noteAVG;
            }
        })
        
        https.get(url, res => {
            let data = '';
            res.on('data', chunk => {
                data += chunk;
            });
            res.on('end', () => {
                data = JSON.parse(data);

                connection.query('SELECT * FROM film WHERE id = ?', [filmId], async (error, results) => {
                    if (results.length == 0) {
                        connection.query('INSERT INTO film SET ?', { id: filmId, name: data.title }, async (error, results) => {
                            if (error) {
                                console.log(error);
                            } else {
                                connection.query('INSERT INTO record SET ?', { film_id: filmId, user_id: req.session.userId }, async (error, results) => {
                                    if (error) {
                                        console.log(error);
                                    }
                                })
                            }
                        })
                    } else {
                        connection.query('INSERT INTO record SET ?', { film_id: filmId, user_id: req.session.userId }, async (error, results) => {
                            if (error) {
                                console.log(error);
                            }
                        })
                    }
                })
                
                
                
            })
        }).on('error', err => {
            console.log(err.message);
            
        })
        res.render('about',{
            login: true,
            noteNumber: noteAVG
        });
        

    } else {
        res.render('login', {
            alert: true,
            alertTitle: "Login",
            AlertMessage: "¡Incorrect login!",
            alertIcon: 'warning',
            showConfirmButton: true,
            timer: false,
            ruta: 'login'
        });
    }
    

})
app.listen(3000, (req, res) => {
    console.log('SERVER RUNING IN http://localhost:3000');
});

