<div id="top-module-container">
    <? if(TRUE): ?>
        <script src="catalog/view/javascript/ajax2login.js"></script>
        <script>
            $(document).ready(function(){
                var
                loginModule = $('#top-login-module' ),
                forgotModule = $('#top-forgot-module'),
                registerModule = $('#top-register-module'),
                currentModule;

                Ajax2login('#top-register-module form', 'register');
                Ajax2login('#top-login-module form', 'login');
                Ajax2login('#top-forgot-module form', 'forgot');

                loginModule.hide();
                forgotModule.hide();

                registerModule.show();
                currentModule = registerModule;

                $('#top-module-container .control-link').on('click', function(){
                    var _this = $(this);
                    var nextModule;

                    if(_this.hasClass('register-form-link'))
                        nextModule = registerModule;
                    if(_this.hasClass('login-form-link'))
                        nextModule = loginModule;
                    if(_this.hasClass('forgot-form-link'))
                        nextModule = forgotModule;

                    currentModule.animate({ top: '-100px' }, 300, 'easeInCirc', function () {
                        currentModule.hide();
                        nextModule
                            .css('top', '-100px')
                            .show()
                            .animate({ top: '0px' }, 300, 'easeOutCirc');
                        currentModule = nextModule;
                    });
                });
            });
        </script>

        <div id="top-register-module">
            <form action="<?=$register_action;?>">
                <input type="email" name="email" placeholder="Email">
                <button type="submit"><?=$button_register;?></button>
            </form>
            <span class="login-form-link control-link"><?=$link_login;?></span>
            <span class="forgot-form-link control-link"><?=$link_forgot;?></span>
        </div>

        <div id="top-forgot-module">
            <form action="<?=$forgot_action;?>">
                <input type="email" name="email" placeholder="Email">
                <button type="submit"><?=$button_forgot;?></button>
            </form>
            <span class="login-form-link control-link"><?=$link_login;?></span>
            <span class="register-form-link control-link"><?=$link_register;?></span>
        </div>

        <div id="top-login-module">
            <form action="<?=$login_action;?>">
                <input type="email" name="email" placeholder="Email">
                <input type="password" name="password" placeholder="<?=$text_password;?>">
                <button type="submit"><?=$button_login;?></button>
            </form>
            <span class="register-form-link control-link"><?=$link_register;?></span>
            <span class="forgot-form-link control-link"><?=$link_forgot;?></span>
        </div>
    <? else: ?>
        <span class="top-links">
            <a href="">Личный кабинет</a>
            <a href="">Выйти</a>
        </span>
    <? endif; ?>
</div>
