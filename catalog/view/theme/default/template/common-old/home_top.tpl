<body>
<header>

    <div id="top-module-container">
        <? if(TRUE): ?>
        <script src="catalog/view/javascript/ajax2login.js"></script>
        <script>
            $(document).ready(function () {
                var
                        loginModule = $('#top-login-module'),
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

                $('#top-module-container .control-link').on('click', function () {
                    var _this = $(this);
                    var nextModule;

                    if (_this.hasClass('register-form-link'))
                        nextModule = registerModule;
                    if (_this.hasClass('login-form-link'))
                        nextModule = loginModule;
                    if (_this.hasClass('forgot-form-link'))
                        nextModule = forgotModule;

                    currentModule.animate({top: '-100px'}, 300, 'easeInCirc', function () {
                        currentModule.hide();
                        nextModule
                                .css('top', '-100px')
                                .show()
                                .animate({top: '0px'}, 300, 'easeOutCirc');
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


    <div class="header">
        <div class="head-container">
            <div class="head-logo"><img src="/catalog/view/theme/default/image/logo-1.png" alt="logo-1"/>

                <h1>FREEPEO</h1></div>
            <div class="head-button">
                <? if($logged):?>
                    <a href="<?=$this->url->link('account/logout');?>">Выход</a>
                <? else: ?>
                    <div id="login-btn">
                        <img src="/catalog/view/theme/default/image/button-arrow.png" alt="arrow" style="vertical-align: middle">
                        Вход
                    </div>
                <? endif; ?>

                <?php echo $language; ?>
            </div>

            <div class="shape">
                <img src="/catalog/view/theme/default/image/shape-1.png" alt="shape-1"/> <br/>

                <div class="shape-text">FREEPEO - THE PROJECT <br/> THAT WILL CHANGE <br/> YOUR LIFE</div>
                <br/>
                <img src="/catalog/view/theme/default/image/shape-2.png" alt="shape-2"/>
            </div>
            <div class="email">
                <span>Get the advantages of being the first!</span> <br/>
                <input type="text" size="30" placeholder="Email Address">
                <input type="submit" value="Get Started">
            </div>
            <div class="man-1">
                <img src="/catalog/view/theme/default/image/man-1.png" alt="man-1"/>
            </div>
        </div>
    </div>
</header>
<div id="wrapper">
    <div class="main">

