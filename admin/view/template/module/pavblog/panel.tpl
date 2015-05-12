<?php  echo $header;  ?>
<div id="content" class="container">
              <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
              </ul>
              <div class="toolbar"><?php require( dirname(__FILE__).'/toolbar.tpl' ); ?></div>
              <?php if ($error_warning) { ?>
              <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
              </div>
              <?php } ?>
              
              <div class="panel panel-default">
                  <div class="panel-heading">
                 <div class="pull-right">
                    <button type="submit" form="form-category" class="btn btn-primary" onclick="$('#form').submit();"><i class="fa fa-check"></i> <?php echo $button_save; ?></button>
                  </div>
                  <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
                </div>
                <div class="panel-body">
				<div class="row">
					
					<div class="col-xs-6">
						
						 <ul class="nav nav-tabs">
							<li class="active"><a href="#panel-lastest" data-toggle="tab"><?php echo $this->language->get('Latest Blog');?></a></li>
							<li><a href="#panel-mostread" data-toggle="tab"><?php echo $this->language->get('Most Read');?></a></li>
							<li><a href="#panel-comments" data-toggle="tab"><?php echo $this->language->get('Latest Comment');?></a></li>	
						</ul>
						<div class="tab-content">
						<div id="panel-lastest" class="tab-pane active">
							<ol>
							<?php  $i=0; foreach( $newest as $blog ) { ?>
								<li>
									<a href="<?php echo $this->url->link("module/pavblog/blog","id=".$blog['blog_id']."&token=".$token);?>"><?php echo $blog['title'];?></a>
								</li>
							<?php } ?>
							</ol>
						</div>
						<div id="panel-mostread" class="tab-pane">
							<ol>
							<?php foreach( $mostread as $blog ) { ?>
								<li>
									<a href="<?php echo $this->url->link("module/pavblog/blog","id=".$blog['blog_id']."&token=".$token);?>"><?php echo $blog['title'];?></a>
								</li>
							<?php } ?>
							</ol>
						</div>
						<div id="panel-comments" class="tab-pane">							<ol>
								<?php foreach( $comments as $comment ) { ?>
								<li><a href="<?php echo $this->url->link("module/pavblog/comment","id=".$comment['comment_id']."&token=".$token);?>"><?php echo utf8_substr($comment['comment'],0,100);?></a></li>
								<?php } ?>
							</ol>
						</div>
						</div>
					</div>
					
                    <div class="col-xs-6">
                        <div class="clearfix pav-toolbar">
                            <div class="suggest-urls">
                                <div>
                                    <h4><?php echo $this->language->get('text_modules_urls');?></h4>
                                    <ol>    
                                        <li>
                                            <div><b><?php echo $this->language->get('text_front_page');?></b></div>

                                             <?php echo $this->language->get('text_normal');?>: <?php echo HTTPS_CATALOG."index.php?route=pavblog/blogs";?><br>
                                             <?php echo $this->language->get('text_seo');?>: <?php echo HTTPS_CATALOG. $module_setting['keyword_listing_blogs_page']; ?>
                                        </li>

                                        <li>

                                            <div><b><?php echo $this->language->get('text_category_page'); ?></b></div>
                                         
                                            <?php echo $this->language->get('text_normal');?>: <?php echo HTTPS_CATALOG."index.php?route=pavblog/category&id=";?>CATEGORY_ID <br>
                                            <?php echo $this->language->get('text_seo');?>: <?php echo HTTPS_CATALOG.'<b>Category - Keyword</b>';?> 
                                        </li>
                                        <li>
                                            <div><b><?php echo $this->language->get('text_item_page')?></b>: </div>
                                            <?php echo $this->language->get('text_normal');?>: <?php echo HTTPS_CATALOG."index.php?route=pavblog/blog/id=";?>BLOG_ID<br>
                                            <?php echo $this->language->get('text_seo');?>: <?php echo HTTPS_CATALOG.'<b>Blog - Keyword</b>';?> 
                                        </li>
                                        
                                        <li>
                                            <div><b><?php echo $this->language->get('text_filter_blog');?></b></div>
                                            <?php echo $this->language->get('text_normal');?>: <?php echo HTTPS_CATALOG."index.php?route=pavblog/blogs&tag=";?><b>TAG_NAME</b><br>
                                            <?php echo $this->language->get('text_seo');?>: <?php echo $this->language->get('text_seo');?>: <?php echo HTTPS_CATALOG. $module_setting['keyword_listing_blogs_page']; ?>?tag=<b>TAG_NAME</b>
                                        </li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>
				</div>
			</div>
		</div>	
		
		
 </div>
 
 <script type="text/javascript">
	$('.htabs a').tabs();

	$("#guide-links a").click( function(){
	
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="'+$(this).attr('href')+'" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: 'Guide',
		close: function (event, ui) {},	
		bgiframe: false,
		width: 900,
		height: 550,
		resizable: false,
		modal: true
	});
		return false; 
	 });
 </script>
<?php echo $footer; ?>
