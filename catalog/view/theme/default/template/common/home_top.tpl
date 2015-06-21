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
<div class="alert-holder">
    <div class="overlay"></div>
    <div class="alert-content">
        <div class="close"></div>
        <div class="moule" id="top-register-module">
            <form action="<?=$register_action;?>">
                <input type="email" name="email" placeholder="Email">
                <button type="submit"><?=$button_register;?></button>
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

        <div class="moule" id="top-login-module">
            <form action="<?=$login_action;?>">
                <input type="email" name="email" placeholder="Email">
                <input type="password" name="password" placeholder="<?=$text_password;?>">
                <button type="submit"><?=$button_login;?></button>
            </form>
            <span class="register-form-link control-link"><?=$link_register;?></span>
            <span class="forgot-form-link control-link"><?=$link_forgot;?></span>
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
                    <p>FREEPEO - THE PROJECT THAT WILL CHANGE YOUR LIFE</p>
                </div>
                <form class="email-form" action="#">
                    <div class="title">Get the advantages of being the first!</div>
                    <fieldset>
                        <input type="email"  placeholder="Email Address">
                        <input type="submit" value="Get Started">
                    </fieldset>
                </form>
            </div>
            <div class="header-man">
                <img src="/catalog/view/theme/default/image/man.png" alt="man"/>
            </div>
        </header>
        <div id="content">
            <div class="about-holder">
                <div class="title-holder"><span>ЧТО ТАКОЕ FREEPEO</span></div>
                <p class="introtext">Международная социо-экономическая сеть, где можно:</p>
                <ul>
                    <li class="item1">
                        <a href="#">
                            <span class="title">СПРАВЕДЛИВО ОЦЕНИВАТЬ СВОЙ ТРУД</span>
                            <p>Рыбные тексты также применяются для демонстрации различных</p>
                        </a>
                    </li>
                    <li class="item2">
                        <a href="#">
                            <span class="title">ИСКАТЬ ПАРТНЕРОВ, ПОСТАВЩИКОВ,ИНВЕСТОРОВ, КЛИЕНТОВ</span>
                            <p>Рыбные тексты также применяются для демонстрации различных</p>
                        </a>
                    </li>
                    <li class="item3">
                        <a href="#">
                            <span class="title"> ПРОВОДИТЬ ПЛАТЕЖИ  МОМЕНТАЛЬНО И БЕЗ КОМИССИЙ</span>
                            <p>Рыбные тексты также применяются для демонстрации различных</p>
                        </a>
                    </li>
                    <li class="item4">
                        <a href="#">
                            <span class="title">ВТОМАТИЗИРОВАТЬ БИЗНЕС-ПРОЦЕССЫ</span>
                            <p>Рыбные тексты также применяются для демонстрации различных</p>
                        </a>
                    </li>
                    <li class="item5">
                        <a href="#">
                            <span class="title">ИНВЕСТИРОВАТЬ ДЕНЬГИ В  ИНТЕРЕСНЫЕ ПРОЕКТЫ</span>
                            <p>Рыбные тексты также применяются для демонстрации различных</p>
                        </a>
                    </li>
                    <li class="item6">
                        <a href="#">
                            <span class="title">ЗАРАБАТЫВАТЬ БЛАГОДАРЯ РЕФЕРАЛЬНОЙ СИСТЕМЕ</span>
                            <p>Рыбные тексты также применяются для демонстрации различных</p>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="who-need-holder">
                <div class="title-holder"><span>ДЛЯ КОГО ЭТО НУЖНО</span></div>
                <p class="introtext">Команда единомышленников, мы хотим создать продукт, которым будем пользоваться сами. Наша целевая аудитория - потребители, производители, инвесторы.</p>
                <ul>
                    <li class="item1">
                            <span class="img"></span>
                            <span class="title">ПОТРЕБИТЕЛЯМ</span>
                            <p>Покупать товар по справедливой цене напрямую у производителя с минимальной накруткой при максимальном качестве.</p>
                    </li>
                    <li class="item2">
                            <span class="img"></span>
                            <span class="title">ПРОИЗВОДИТЕЛЯМ</span>
                            <p>полная организация процесса производства и прямой доступ на огромный рынок с клиентской базой.</p>
                    </li>
                    <li class="item3">
                            <span class="img"></span>
                            <span class="title">ИВЕСТОРАМ</span>
                            <p>благодаря новой модели ценообразования, можно получать стабильную прибыль с минимальными рисками. </p>
                    </li>
                </ul>
            </div>
            <div class="why-need-holder">
                <div class="title-holder"><span>ЗАЧЕМ ВАМ ЭТО НУЖНО</span></div>
                <p class="introtext">Проект FreePeo решит эти и многие другие вопросы. Интернет уже никогда не будет прежним.</p>
                <div class="row">
                    <div class="man">
                        <img src="/catalog/view/theme/default/image/man.jpg" alt=""/>
                    </div>
                    <div class="text-container">
                        <ul>
                            <li>
                                <span>1</span>
                                <p>“Может вы устали от ощущения кота в мешке, делая покупки в интернете?”</p>
                            </li>

                            <li>
                                <span>2</span>
                                <p>“Вам сложно найти надежных партнеров или квалифицированных работников?”</p>
                            </li>
                            <li>
                                <span>3</span>
                                <p>“Вы хотите разумно использовать свои сбережения или увеличить капитал?”</p>
                            </li>
                            <li>
                                <span>4</span>
                                <p>“Вас тоже возмущают банковские комиссии на каждом шагу?”</p>
                            </li>
                        </ul>
                        <form  class="email-form" action="#">
                            <div class="title">Get the advantages of being the first!</div>
                            <fieldset>
                                <input type="email"  placeholder="Email Address">
                                <input type="submit" value="Get Started">
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>