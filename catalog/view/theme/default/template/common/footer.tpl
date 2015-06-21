    <footer class="footer">
        <div class="row">
            <a href="#" class="footer-logo"></a>
            <ul class="navigation">
                <li><a href="#">Святься с нами</a></li>
                <li><a href="#">Условия пользования</a></li>
            </ul>
            <ul class="social">
                <li class="item1"><a href="#"></a></li>
                <li class="item2"><a href="#"></a></li>
                <li class="item3"><a href="#"></a></li>
                <li class="item4"><a href="#"></a></li>
            </ul>
            <div class="text">
                <span>Для того  чтобы всегда узнавать <br/>самые последние новости следите <br/>за нами в социальных сетях:</span>
            </div>
        </div>
    </footer>
    </div>
    </div>
    <!-- Scripts appended to footer -->
    <?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>" type="text/javascript"></script>
    <?php } ?>
    <?php foreach ($styles as $style) { ?>
    <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>"
          media="<?php echo $style['media']; ?>"/>
    <?php } ?>
    <!-- Styles appended to footer -->
    </body>
</html>