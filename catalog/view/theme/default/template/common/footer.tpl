            </div>
        </div> 
        <footer class="footer">
            <?php echo $powered; ?>
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