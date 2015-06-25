<!--allert-->
<? if(TRUE): ?>
<script src="catalog/view/javascript/ajax2login.js"></script>
<script>
    $(document).ready(function () {
        var loginModule = $('#top-login-module'),
            forgotModule = $('#top-forgot-module'),
            registerModule = $('#top-register-module'),
            currentModule;

        Ajax2login('#top-register-module form', 'register');
        Ajax2login('#bot-register-module', 'register');
        Ajax2login('#top-login-module form', 'login');
        Ajax2login('#top-forgot-module', 'forgot');

        loginModule.show();
        forgotModule.hide();
        registerModule.hide();
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
<div class="alert-holder">
    <div class="overlay"></div>
    <div class="alert-content">
        <div class="close">Закрыть</div>
        <div class="moule" id="top-login-module">
            <form action="<?=$login_action;?>">
                <input type="email" name="email" placeholder="Email">
                <input type="password" name="password" placeholder="<?=$text_password;?>">
                <button type="submit"><?=$button_login;?></button>
            </form>
            <span class="register-form-link control-link"><?=$link_register;?></span>
            <span class="forgot-form-link control-link"><?=$link_forgot;?></span>
        </div>

        <div class="moule" id="top-register-module">
            <form action="<?=$register_action;?>">
                <div class="row">
                    <input type="email" name="email" placeholder="Email">
                </div>
                <div class="row-box">
                    <button type="submit"><?=$button_register;?></button>
                </div>

            </form>
            <span class="login-form-link control-link"><?=$link_login;?></span>
            <span class="forgot-form-link control-link"><?=$link_forgot;?></span>
        </div>

        <div class="moule" id="top-forgot-module">
            <form action="<?=$forgot_action;?>">
                <input type="email" name="email" placeholder="Email">
                <button type="submit"><?=$button_forgot;?></button>
            </form>
            <span class="login-form-link control-link"><?=$link_login;?></span>
            <span class="register-form-link control-link"><?=$link_register;?></span>
        </div>
    </div>
</div>
<? endif; ?>
<!--allert/-->

<div id="wrapper">
    <div class="main">
        <header class="header" id="bg-holder">
            <div class="top">
                <strong class="logo"><a href="/">FREEPEO</a></strong>
                <div class="authorization-holder">
                    <? if($logged):?>
                        <a  class="logout" href="<?=$this->url->link('account/logout');?>">Выход</a>
                    <? else: ?>
                        <a class="login" href="#">Вход</a>
                        <a class="register" href="#">Регистрация</a>
                    <? endif; ?>
                </div>
                <div class="lang-holder">
                    <?php echo $language; ?>
                </div>
            </div>
            <div class="header-main">
                <div class="slogan">
                    <span class="element"></span>
                    <p>FREEPE - THE PROJECT THAT WILL CHANGE YOUR LIFE</p>
                </div>
                <form class="email-form" action="<?=$register_action;?>" id="bot-register-module">
                    <div class="title">Get the advantages of being the first!</div>
                    <fieldset>
                        <input type="email" name="email" placeholder="Email Address">
                        <input type="submit" name="submit" value="STEP INSIDE">
                    </fieldset>
                </form>
            </div>
            <div class="header-man">
                <img src="/catalog/view/theme/default/image/man.png" alt="man"/>
            </div>
        </header>