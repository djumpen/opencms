</div>
<footer>
  <p class="text-center"><?php echo $text_footer; ?></p>
</footer>
<!-- Scripts appended to footer -->
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($typeScripts as $typeScripts) { ?>
<script type="text/typescript" src="<?php print $typeScripts; ?>"></script>
<?php } ?>
<!-- Scripts appended to footer -->
</body></html>