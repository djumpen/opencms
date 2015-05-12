var Ajax2login = function(selector, action){
    var obj = {
        selector: '',
        action: '',
        actionUrl: '',
            form: {},
        bind: function(selector, action){
            this.selector = selector;
            var _this = this;

            $(document).on('submit', selector, function(e){
                _this.form = $(_this.selector).serializeObject();
                _this.actionUrl = $(_this.selector).attr('action');
                if(action == 'login')
                    _this.login();
                if(action == 'register')
                    _this.register();
                e.preventDefault();
            });
        },
        validate: function(){
            var errors = 0;
            for(key in this.form) {
                if(this.form[key].length < 2) {
                    errors++;
                    $(this.selector + ' input[name="' + key + '"]').addClass('error');
                } else {
                    $(this.selector + ' input[name="' + key + '"]').removeClass('error');
                }
            }
            return (errors < 1);
        },
        login: function(login, password){
            if(this.validate()) {
                var _this = this;
                $.ajax({
                    url: getLink('account/login/ajax2login'),
                    data: _this.form,
                    dataType: 'json',
                    type: 'post',
                    success: function(response){
                        if(response.ok) {
                            if(window.location.pathname == '/logout'){
                                window.location.href = '/';
                            } else {
                                window.location.reload();
                            }
                        } else if(response.errors) {
                            for(key in response.errors) {
                                _this.error(response.errors[key]);
                            }
                        }
                    }
                });
            } else {
                this.error('Неправильно заполнены поля E-Mail и/или пароль!');
            }
        },
        register: function(){
            console.log(this.form);
            if(this.validate()) {
                var _this = this;
                $.ajax({
                    url: _this.actionUrl, //getLink('account/register/ajax2register'),
                    data: _this.form,
                    dataType: 'json',
                    type: 'post',
                    success: function(response){
                        if(response.ok) {
                            window.location.href = '/';
                        } else if(response.error) {
                            for(key in response.messages) {
                                _this.error(response.messages[key]);
                            }
                        }
                    }
                });
            } else {
                this.error('Неправильно заполнены поля E-Mail и/или пароль!');
            }
        },
        forgot: function(login){
            $.ajax({
                url: getLink('account/login/ajax2forgot'),
                data: {email: login},
                dataType: 'json',
                type: 'post',
                success: function(response){
                    if(response.ok && response.redirect) {
                        window.location.href = response.redirect;
                    } else if(response.errors) {
                        for(key in response.errors) {
                            this.error(response.errors[key]);
                        }
                    }
                }
            });
        },
        error: function(error){
            var opts = {
                text: error,
                styling: 'bootstrap3',
                addclass: 'oc_noty',
                type: 'error',
                icon: 'picon picon-32 picon-fill-color',
                opacity: .8,
                nonblock: {
                    nonblock: true
                }
            };
            new PNotify(opts);
        }
    }
    obj.bind(selector, action);
    return obj
}