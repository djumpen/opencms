<?php  echo $header;  ?>

<div id="content" class="container">
	<ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ul>
	<div class="toolbar"><?php require( dirname(__FILE__).'/toolbar.tpl' ); ?></div>
	<?php if ($error_warning) { ?>
	  <?php foreach ($error_warning as $error) { ?>
	    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error ?>
		  <button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
	  <?php } ?>
	<?php } ?>
	
	<div class="panel panel-default">
		
		<div class="panel-heading">
			<h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
			<div class="button-group">
				<a onclick="$('#form').submit();" class="btn btn-success"><?php echo $this->language->get("button_save"); ?></a>
				<a onclick="__submit('save-edit')" class="btn btn-default"><?php echo $this->language->get('button_save_edit'); ?></a>
				<a onclick="__submit('save-new')" class="btn btn-default"><?php echo $this->language->get('button_save_new'); ?></a>
				<?php if( $blog['blog_id'] ) { ?>	
				<a  href="<?php echo $action_delete;?>" class="btn btn-danger action-delete"><?php echo $this->language->get("button_delete"); ?></a>	
				<?php } ?>
			</div>  
		</div>
		
		<div class="panel-body">
			<div class="box-columns">
				<form id="form" enctype="multipart/form-data" method="post" action="<?php echo $action;?>">
					<input type="hidden" name="action_mode" id="action_mode" value=""/>
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $this->language->get("text_general"); ?></a></li>
						<li><a href="#tab-gallery" data-toggle="tab"><?php echo $this->language->get("text_gallery"); ?></a></li>
						<li><a href="#tab-meta" data-toggle="tab"><?php echo $this->language->get("text_meta"); ?></a></li>
					</ul>
					<div class="tab-content">
						<div id="tab-general" class="tab-pane active">
							<input type="hidden" name="pavblog_blog[blog_id]" value="<?php echo $blog['blog_id'];?>"/>
							<div>
								<table  class="table table-striped table-bordered table-hover">
									<tr>
										<td><?php echo $this->language->get('entry_category_id');?></td>
										<td><?php echo $menus;?></td>
									</tr>
									<tr>
										<td><?php echo $this->language->get('entry_status');?></td>
										<td>
											<select class="form-control" name="pavblog_blog[status]">
												<?php foreach( $yesno as $k=>$v ) { ?>
												<option value="<?php echo $k;?>" <?php if( $k==$blog['status'] ) { ?> selected="selected" <?php } ?>><?php echo $v;?></option>
												<?php } ?>
											</td>
										</tr>
										<tr style="display:none;">
											<td><?php echo $this->language->get('entry_featured');?></td>
											<td>
												<select class="form-control" name="pavblog_blog[featured]">
													<?php foreach( $yesno as $k=>$v ) { ?>
													<option value="<?php echo $k;?>" <?php if( $k==$blog['featured'] ) { ?> selected="selected" <?php } ?>><?php echo $v;?></option>
													<?php } ?>
												</td>
											</tr>
											<tr>
												<td><?php echo $this->language->get('entry_hits');?></td>
												<td>
													<input type="text" class="form-control" name="pavblog_blog[hits]" value="<?php echo $blog['hits'];?>">
												</td>
											</tr>
											<tr>
												<td><?php echo $this->language->get('entry_tags');?></td>
												<td>
													<input type="text" class="form-control" name="pavblog_blog[tags]" value="<?php echo $blog['tags'];?>" size="150">
													<br><i><?php echo $this->language->get('text_explain_tags');?></i>
												</td>
											</tr>
											<tr>
												<td><?php echo $this->language->get('entry_created');?></td>
												<td>
													<input type="text" class="form-control" name="pavblog_blog[created]" value="<?php echo $blog['created'];?>" class="date">
												</td>
											</tr>
											<tr>
												<td><?php echo $this->language->get('entry_creator');?></td>
												<td>
													<select class="form-control" name="pavblog_blog[user_id]">
														<?php foreach( $users as $user ) { ?> 
														<option value="<?php echo $user['user_id'];?>" <?php if( $user['user_id'] == $blog['user_id'] ){ ?>selected="selected"<?php } ?>><?php echo $user['username'];?></option>
														<?php } ?>
													</select>
												</td>
											</tr>
											
										</table>
									</div>
									
									<ul id="language-blog" class="nav nav-tabs">
										<?php $i = 0; foreach ($languages as $language) { ?>
										<li class="<?php if($i == 0) : ?> active <?php endif; ?>"><a href="#tab-language-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
										<?php $i++; } ?>
									</ul>
									<div class="tab-content">
										<?php $i = 0; foreach ($languages as $language) { ?>
										<div id="tab-language-<?php echo $language['language_id']; ?>" class="tab-pane <?php if($i == 0) : ?> active <?php endif; ?>">
											<table  class="table table-striped table-bordered table-hover">
												<tr>
													<td><?php echo $this->language->get('entry_title');?></td>
													<td><input  class="form-control" name="pavblog_blog_description[<?php echo $language['language_id'];?>][title]" size="120" value="<?php echo $pavblog_blog_descriptions[$language['language_id']]['title'];?>"/></td>
												</tr>
												<tr>
													<td><?php echo $this->language->get('entry_description');?></td>
													<td>
														<textarea class="form-control" name="pavblog_blog_description[<?php echo $language['language_id'];?>][description]"  rows="6" cols="10"><?php echo $pavblog_blog_descriptions[$language['language_id']]['description'];?></textarea>
													</td>
												</tr>
											</tr>
											<tr>
												<td><?php echo $this->language->get('entry_content');?></td>
												<td>
													<textarea class="form-control" name="pavblog_blog_description[<?php echo $language['language_id'];?>][content]"  rows="6" cols="10"><?php echo $pavblog_blog_descriptions[$language['language_id']]['content'];?></textarea>
												</td>
											</tr>
										</table>
									</div>
									<?php $i++; } ?>
								</div> 
								
							</div>
							<div id="tab-gallery" class="tab-pane">
								<div>
									<table  class="table table-striped table-bordered table-hover">
										
										<tr>
											<td><?php echo $this->language->get('entry_image');?></td>
											
											<td class="left"><div class="image"><img src="<?php echo $blog['thumb']; ?>" alt="" id="blog-thumb" />
												<input type="hidden" name="pavblog_blog[image]" value="<?php echo $blog['image']; ?>" id="blog-image"  />
												<div class="btn-group">
													<a  data-toggle="modal" data-target="#dialog" onclick="image_upload('blog-image', 'blog-thumb');" class="btn btn-success"><?php echo $text_browse; ?></a><a  class=" btn btn-danger"onclick="$('#blog-thumb').attr('src', '<?php echo $no_image; ?>'); $('#blog-image').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
												</div>
											</tr>
											
											<tr>
												<td><?php echo $this->language->get('entry_video_code');?></td>
												<td><textarea class="form-control"  name="pavblog_blog[video_code]" rows="6" cols="40"><?php echo $blog['video_code'];?></textarea></td>
											</tr>
											
											
										</table>
									</div>
								</div>
								<div id="tab-meta" class="tab-pane">
									<div class="pav-content" style="width:100%">
										<table  class="table table-striped table-bordered table-hover">
											<tr>
												<td><?php echo $this->language->get('entry_keyword');?></td>
												<td><input type="text" class="form-control" name="pavblog_blog[keyword]" size="100" value="<?php echo $blog['keyword'];?>"/></td>
											</tr>
											<tr>
												<td><?php echo $this->language->get('entry_meta_title');?></td>
												<td><input type="text" class="form-control" name="pavblog_blog[meta_title]" value="<?php echo $blog['meta_title'];?>"/></td>
											</tr>
											<tr>
												<td><?php echo $this->language->get('entry_meta_keyword');?></td>
												<td><textarea class="form-control"  name="pavblog_blog[meta_keyword]"><?php echo $blog['meta_keyword'];?></textarea></td>
											</tr>
											<tr>
												<td><?php echo $this->language->get('entry_meta_description');?></td>
												<td><textarea class="form-control"  name="pavblog_blog[meta_description]" rows="6" cols="40"><?php echo $blog['meta_description'];?></textarea></td>
											</tr>
											
											
										</table>
									</div>
								</div>
							</div>
						</form>
						
					</div>
					
					
				</div>
			</div>	
			
			
		</div>
		<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
		<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
		<script type="text/javascript">
			$('.date').datepicker({dateFormat: 'yy-mm-dd'});
			$('.pavhtabs a').tabs();
			$('.pavtabs a').tabs();
			function __submit( val ){
				$("#action_mode").val( val );
				$("#form").submit();
			}
			$(".action-delete").click( function(){ 
				return confirm( "<?php echo $this->language->get("text_confirm_delete");?>" );
			} );
			<?php foreach ($languages as $language) { ?>
				CKEDITOR.replace('pavblog_blog_description[<?php echo $language['language_id']; ?>][description]', {
					filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
				});
				<?php } ?>
				<?php foreach ($languages as $language) { ?>
					CKEDITOR.replace('pavblog_blog_description[<?php echo $language['language_id']; ?>][content]', {
						filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
						filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
						filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
						filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
						filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
						filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
					});
					<?php } ?>

					function image_upload(field, thumb) {

						$('#dialog').attr('data-field', field);
						$('#dialog').attr('data-thumb', thumb);
						$('#dialog #fm-iframe').attr('src', 'index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field));
					};

					$(document.body).on('show.bs.modal', '#dialog', function () {
						$(this).find('#dialog-confirm').addClass('hide');
					});

					$(document.body).on('hidden.bs.modal', '#dialog', function () {
						var field = $(this).attr('data-field');
						var thumb = $(this).attr('data-thumb');
						
						if ($('#' + field).attr('value')) {
							$.ajax({
								url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
								dataType: 'text',
								success: function(data) {
									$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '">');
								}
							});
						}
						$('#dialog').attr('data-field', '');
						$('#dialog').attr('data-thumb', '');
						$('#dialog #fm-iframe').attr('src', '');
					});
				</script>
				<div class="modal fade" id="dialog" data-field="" data-thumb="">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
									&times;
								</button>
								<h4 class="modal-title"><?php echo $text_image_manager; ?></h4>
							</div>
							<div class="modal-body">
								<iframe id="fm-iframe" style="display:block; border:0; padding:0; margin:0; width:100%; height:360px; overflow:auto;"></iframe>
							</div>
							<div class="modal-footer">
								<a href="#" id="dialog-confirm" class="btn btn-success hide"><i class="fa fa-thumbs-up"></i> Confirm</a>
								<a href="#" class="btn btn-success" data-dismiss="modal" aria-hidden="true">Close</a>
							</div>
						</div>
					</div>
				</div>
				<?php echo $footer; ?>
