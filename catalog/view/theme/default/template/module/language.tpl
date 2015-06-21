<?php if (count($languages) > 1) { ?>
<form class="lang-form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" name="language">
    <div class="lang">
    <?php foreach ($languages as $language) { ?>
        <?php if ($language['code'] == $language_code) { ?>
             <span><?php echo $language['name']; ?></span>
            <i class="seporator"></i>
        <?php } else { ?>
            <a onclick="$('input[name=\'language_code\']').attr('value', '<?php echo $language['code']; ?>'); $('.lang-form').submit();">
                <?php echo $language['name']; ?>
            </a>
             <i class="seporator"></i>
        <?php } ?>
    <?php } ?>
    </div>
  <input type="hidden" name="language_code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
<?php } ?>
