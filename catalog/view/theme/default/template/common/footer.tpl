            </div>
        </div>
            <footer>
                <div class="footer-container">
                    <div class="footer-logo"><img src="img/footer-logo.png" alt="footer-logo"/></div>
                    <div class="contacts">
                        <div class="link">
                            <a href="#"><div class="arrow-w"></div> <span>Святься с нами</span></a>
                        </div>
                        <div class="link">
                            <a href="#"><div class="arrow-w"></div> <span>Условия пользования</span></a>
                        </div>
                    </div>
                    <div class="social-networks">
                        <span>Для того  чтобы всегда узнавать <br/>самые последние новости следите <br/>за нами в социальных сетях:</span>
                        <a href="#"><div class="network-1"></div></a>
                        <a href="#"><div class="network-2"></div></a>
                        <a href="#"><div class="network-3"></div></a>
                        <a href="#"><div class="network-4"></div></a>
                    </div>
                </div>
                <div class="footer-border">

                </div>

            </footer>

        <!-- Scripts appended to footer -->
        <?php foreach ($scripts as $script) { ?>
        <script src="<?php echo $script; ?>" type="text/javascript"></script>
        <?php } ?>
        <?php foreach ($styles as $style) { ?>
        <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
        <?php } ?>
        <!-- Styles appended to footer -->
        <p id="topon" style="display: block">
        	<a href="#top"><span></span></a>
        </p>
    </body>
    </html>