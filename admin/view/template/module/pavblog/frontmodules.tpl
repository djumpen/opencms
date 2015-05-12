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
              <h1 class="panel-title"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
                <div class="button-group">
                  <a onclick="$('#form').submit();" class="btn btn-success"><?php echo $this->language->get("button_save"); ?></a>
                </div>  
            </div>
            
             <div class="panel-body">
			    <form action="<?php echo $action;?>" method="post" id="form">
					

					<div class="module-setting-tabs htabs">
						<ul id="language-blog" class="nav nav-tabs">
							<?php
								if(!empty($layout_modules)){ $i=0;
									foreach($layout_modules as $key=>$modules){ $key = trim($key);?> 
									    <li class="<?php if($i == 0) : ?> active <?php endif; ?>"><a data-toggle="tab" href="#tab-module-<?php echo $key ?>"><?php echo $this->language->get("tab_".strtolower($key)); ?></a></li>
									    <?php $i++; }} ?>
						</ul>
					</div>
					<div class="tab-content">	
					 <?php
						if(!empty($layout_modules)){ $i=0;
							foreach($layout_modules as $key=>$item_module){
								//check the module is not installed
								if(!is_array($item_module)){
									$install_link = $this->url->link('extension/module/install', "extension=$key&token=" . $this->session->data['token'], 'SSL');
									?>
									<div id="tab-module-<?php echo $key;?>" class="tab-pane <?php if($i == 0) : ?> active <?php endif; ?>">
										<div class="tab-inner">
											<p><?php echo $this->language->get("module_not_installed"); ?><a  class="install_button" href="<?php echo $install_link; ?>"><?php echo $this->language->get("install");?></a></p>
											<div class="clear"></div>
										</div>
									</div>
									<?php
								}else{
									$modules_tpl = dirname(__FILE__).'/modules/'.trim($key).'.tpl';
									$modules = $item_module;
									$module_key = $key;
									?>
									<div id="tab-module-<?php echo $key;?>" class="tab-pane <?php if($i == 0) : ?> active <?php endif; ?>">
										<div class="tab-inner">
											<input type="hidden" name="pavblog_frontmodules[modules][]" value="<?php echo $key;?>"/>
											<?php
											if( file_exists($modules_tpl) ){
												require_once($modules_tpl);
											}
											?>
											<div class="clear"></div>
										</div>
									</div>
									
									<?php $i++; }}} ?>
									</div>
					
				
				
			</div>
		</div>	
		
		
 </div>
  
 <script type="text/javascript">
	$(".pavhtabs a").tabs();
	$(".pavmodshtabs a").tabs();
	function __submit( val ){
		$("#action_mode").val( val );
		$("#form").submit();
	}
	var split = location.search.replace('?', '').split('&').map(function(val){
		  return val.split('=');
		});
	var mod_key = "";
	if(split.length){
		for(i=0;i<split.length;i++){
			if(split[i][0] == "mod"){
				mod_key = "#tab-module-"+split[i][1];
				break;
			}
		}
	}

	$('#tabs a').each( function(){
		if( $(this).attr("href") ==  mod_key ){
			$(this).click();
			return ;
		}
	} );
 </script>
 
<?php echo $footer; ?>
