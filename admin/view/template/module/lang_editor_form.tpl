<?php echo $header; ?>
<script type="text/javascript" src="view/javascript/jquery/jquery.scrollTo-1.4.3.1-min.js"></script>
<div id="content" class="container">
	<ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ul>
	<?php if ($error_warning) { ?>
	<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
		<button type="button" class="close" data-dismiss="alert">&times;</button>
	</div>
	<?php } ?>
	<div class="panel panel-default">
		<div class="panel-heading">
			<div class="pull-right">
				<a class="filelistall btn btn-primary" title="<?php echo $entry_showhide; ?>"><?php echo $entry_showhideall; ?></a>
			</div>
			<h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
		</div>
		<div class="panel-body">

			<div class="clr"></div>

			<h2 style="text-transform:uppercase;"><?php echo $entry_title; ?></h2>
			<a class="back_error">˄</a>
			<a class="next_error">˅</a>
			<div class="clr">
				<script type="text/javascript">
					$(document).ready(function(){				
						var notext;
						$('.back_error').click(function() {
							if($('.lang_error:visible:eq(0)').length!=0){
								$('.lang_error:visible:eq(' + notext + ')').stop(true, true);
								$('.lang_error').css('opacity', '0.5');

								if ( notext === undefined) {
									notext=0;
								} else {
									notext=notext-1;
								}
								if($('.lang_error:visible:eq(' + notext + ')').length==0){
									notext=$('.lang_error:visible').length-1;
								}
								$('body').scrollTo($('.lang_error:visible:eq(' + notext + ')'), 200, {offset:-258, } );
								$('.lang_error:visible:eq(' + notext + ')').stop(true, true).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200);
							}else{
								$('body').scrollTo(0, 200);
							}
						});

						$('.next_error').click(function() {
							if($('.lang_error:visible:eq(0)').length!=0){
								$('.lang_error:visible:eq(' + notext + ')').stop(true, true);
								$('.lang_error').css('opacity', '0.5');

								if ( notext === undefined) {
									notext=0;
								} else {
									notext=notext+1;
								}
								if($('.lang_error:visible:eq(' + notext + ')').length==0){
									notext=0;
								}
								$('body').scrollTo($('.lang_error:visible:eq(' + notext + ')'), 200, {offset:-258, } );
								$('.lang_error:visible:eq(' + notext + ')').stop(true, true).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200);
							}else{
								$('body').scrollTo($(document).height(), 200);
							}
						});

						$('.lang_error').live('click', function(){
							notext = $(this).index('.lang_error:visible');

							$('.lang_error').css('opacity', '0.5');
							$('body').scrollTo($(this), 200, {offset:-258, } );
							$(this).stop(true, true).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200);
						});
					});
</script>
<?php 
$show_folder = '';

$td_num = 0;
foreach($paths_array as $path){
	$folder = explode('/', $path);
	if($show_folder != $folder [0]){
		$show_folder = $folder [0];
		?>
	</div>
	<div class="show_hide">
		<a class="filelist btn btn-success" title="<?php echo $entry_showhide; ?>"><?php echo $show_folder; ?></a>
	</div>
	<div class="folders_block">
		<?php } ?>
		<div>
			<?php echo $folder [1]; ?>
			<div class="files_block">
				<form method="post" action="<?php echo $action; ?>">
					<input type="hidden" name="type" value="<?php echo $this->request->post ['type']; ?>" />
					<input type="hidden" name="path" value="<?php echo $path; ?>" />
					<table id="module" class="table table-striped table-bordered table-hover">
						<tr>
							<th style="width: 100px;"></th>
							<?php foreach ($this->request->post ['selected'] as $lang){ ?>
							<th><?php echo $lang; ?></th>
							<?php } ?>
						</tr>
						<?php $input_val = $this->getFileValuesByLang($path, $this->request->post ['selected'], $end_side); ?>
						<?php foreach ($this->getFileVarsByLang($path, $this->request->post ['selected'], $end_side) as $k => $v){ ?>
						<?php $td_num++; ?>
						<tr>
							<td class="tn<?php echo $td_num; ?>"><?php echo $v; ?></td>
							<?php
							$len = 0;
							foreach ($this->request->post ['selected'] as $lang){
								if(isset($input_val{$lang}{$v}) && $len < mb_strlen (@htmlspecialchars($input_val{$lang}{$v}), "UTF-8"))
									$len = mb_strlen (htmlspecialchars($input_val{$lang}{$v}), "UTF-8");
							}
							?>
							<?php $error_var = 0; ?>
							<?php foreach ($this->request->post ['selected'] as $lang){ ?>
							<td>
								<?php if(!isset($input_val{$lang}{$v}) && $error_var==0) { ?>
								<?php $error_var=1; ?>
								<script type="text/javascript">
									$(document).ready(function(){
										$('.tn<?php echo $td_num; ?>').prepend('<div class="lang_error"></div>');
									});
								</script>
								<?php } ?>

								<?php if($len > 25){ ?>
								<textarea class="form-control" name="<?php echo 'data[' . $lang . '][' . $v . ']'; ?>" rows="<?php echo ceil($len / 25);?>"<?php if(!isset($input_val{$lang}{$v})) echo ' class="s"'; ?>><?php echo (isset($input_val{$lang}{$v}) ? htmlspecialchars($input_val{$lang}{$v}) : '') ?></textarea>
								<?php }else{ ?>
								<input class="form-control" type="text" name="<?php echo 'data[' . $lang . '][' . $v . ']'; ?>" value="<?php echo (isset($input_val{$lang}{$v}) ? @htmlspecialchars($input_val{$lang}{$v}) : '') ?>"<?php if(!isset($input_val{$lang}{$v})) echo ' class="s"'; ?> />
								<?php } ?>
							</td>
							<?php } ?>
						</tr>
						<?php } ?>
					</table>
					<div class="buttons">
						<a class="btn btn-primary button_add_var"><span>+</span></a>
						<a class="btn btn-success button_save_lang"><span><?php echo $button_save; ?></span></a>
						<div class="save_time"></div>
					</div>
				</form>
				<div class="clr"></div>

			</div>
		</div>
		<?php } ?>
	</div>


	<div class="folders_block" style="display:block;">
		<div class="show_hide"><?php echo $entry_languages; ?></div>
		<div class="files_block">
			<form method="post" action="<?php echo $action; ?>">
				<input type="hidden" name="type" value="<?php echo $this->request->post ['type']; ?>" />
				<input type="hidden" name="path" value="#main_file" />
				<table id="module" class="table table-striped table-bordered table-hover">
					<tr>
						<th style="width: 100px;"></th>
						<?php foreach ($this->request->post ['selected'] as $lang){ ?>
						<th><?php echo $lang; ?></th>
						<?php } ?>
					</tr>
					<?php $input_val = $this->getFileValuesByLang('#main_file', $this->request->post ['selected'], $end_side); ?>
					<?php foreach ($this->getFileVarsByLang('#main_file', $this->request->post ['selected'], $end_side) as $k => $v){ ?>
					<?php $td_num++; ?>
					<tr>
						<td class="tn<?php echo $td_num; ?>"><?php echo $v; ?>:</td>
						<?php
						$len = 0;
						foreach ($this->request->post ['selected'] as $lang){
							if(isset($input_val{$lang}{$v}) && $len < mb_strlen (htmlspecialchars($input_val{$lang}{$v}), "UTF-8"))
								$len = mb_strlen (htmlspecialchars($input_val{$lang}{$v}), "UTF-8");
						}
						?>
						<?php $error_var = 0; ?>
						<?php foreach ($this->request->post ['selected'] as $lang){ ?>
						<td>

							<?php if(!isset($input_val{$lang}{$v}) && $error_var==0) { ?>
							<?php $error_var=1; ?>
							<script type="text/javascript">
								$(document).ready(function(){
									$('.tn<?php echo $td_num; ?>').prepend('<div class="lang_error"></div>');
								});
							</script>
							<?php } ?>

							<?php if($len > 25){ ?>
							<textarea class="form-control" name="<?php echo 'data[' . $lang . '][' . $v . ']'; ?>" rows="<?php echo ceil($len / 25);?>"<?php if(!isset($input_val{$lang}{$v})) echo ' class="s"'; ?>><?php echo (isset($input_val{$lang}{$v}) ? htmlspecialchars($input_val{$lang}{$v}) : '') ?></textarea>
							<?php }else{ ?>
							<input class="form-control" type="text" name="<?php echo 'data[' . $lang . '][' . $v . ']'; ?>" value="<?php echo (isset($input_val{$lang}{$v}) ? htmlspecialchars($input_val{$lang}{$v}) : '') ?>"<?php if(!isset($input_val{$lang}{$v})) echo ' class="s"'; ?> />
							<?php } ?>
						</td>
						<?php } ?>
					</tr>
					<?php } ?>
				</table>
				<div class="buttons">
					<a class="btn btn-primary button_add_var"><span>+</span></a>
					<a class="btn btn-success button button_save_lang"><span><?php echo $button_save; ?></span></a>
					<div class="save_time"></div>
				</div>
			</form>
			<div class="clr"></div>
		</div>
	</div>






</div>
</div>
<?php

?>
<script type="text/javascript">
	$(document).ready(function(){
		$('.button_add_var').click(function(){
			$(this).parent().prev().append("<tr><td><span>text_</span><br /><input type=\"text\" class=\"new_value\" value=\"text_\" /></td><?php foreach ($this->request->post ['selected'] as $lang){ ?><td><textarea name=\"<?php echo 'data[' . $lang . '][-]'; ?>\" rows=\"3\" class=\"<?php echo $lang; ?>\"></textarea></td><?php } ?></tr>");
		});
		$('.new_value').live('keyup', function(){
			//alert($(this).val());
			$(this).prevAll('span').html($(this).val());
			<?php foreach ($this->request->post ['selected'] as $lang){ ?>
				$(this).parent().nextAll().children('.<?php echo $lang; ?>').attr('name', 'data[<?php echo $lang; ?>][' + $(this).val() + ']');
				<?php } ?>
			});
		
		$('.button_save_lang').click(function(){
			var now = new Date();
			var hours = now.getHours();
			var minutes = now.getMinutes();
			var seconds = now.getSeconds();
			var timeValue = '<?php echo $entry_saved; ?>: ' + ((hours < 10) ? "0" : "") + hours;
			timeValue += ((minutes < 10) ? ":0" : ":") + minutes;
			timeValue += ((seconds < 10) ? ":0" : ":") + seconds;

			
			var save_time = $(this).next('.save_time');
			$.ajax({
				type: 'POST',
				url: $(this).parents('form').attr('action'),
				data: $(this).parents('form').serialize(),
				beforeSend: function() {
					save_time.show();
					save_time.html('<?php echo $entry_saving; ?>');
				},
				success: function(msg) {
					if(msg == 'ok') {
						save_time.fadeOut(500,function(){
							save_time.html(timeValue);
							save_time.fadeIn(500);
						});
					} else if(msg == 'error') {
						alert(msg);
					} else {
						window.location.href = '<?php echo $redirect?>';
					}
				}
			});
		});
		
		$('.filelistall').toggle(function(){
			$('.filelist').parent().next().show();
			$('.filelist').children('img').attr('src','view/image/delete.png');
		},function(){
			$('.filelist').parent().next().hide();
			$('.filelist').children('img').attr('src','view/image/add.png');
		}
		);

		$('.filelist').click(function(){
			$(this).parent().next().toggle();
			if($(this).children('img').attr('src')=='view/image/delete.png')
				$(this).children('img').attr('src','view/image/add.png');
			else
				$(this).children('img').attr('src','view/image/delete.png');
		});

		$('.lang_error').css('opacity', '0.5');
		$('.lang_error').hover(function(){ $(this).css('opacity', '0.7'); },function(){ $(this).css('opacity', '0.5'); });
	});

</script>
