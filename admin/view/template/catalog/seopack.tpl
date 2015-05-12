<?php echo $header; ?>
<script type="text/javascript">
				function clearseo(data, link){						
					if (!confirm('Are you sure you want to delete ALL ' + data + '?\n\nA database backup is recommended! \n\nThis action will delete ALL ' + data + '!!!')) 
						{
							return false;
						}
						else 
						{
							location = link;
						}
						
					}
				</script>
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
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="panel panel-default">
	 <div class="panel-heading">
    	 <div class="row">
             <div class="container">
                  <h1 class="panel-title pull-left"><i class="fa fa-edit"></i> <?php echo $heading_title; ?></h1>
                  <div class="button-group pull-right">
                      <button type="button"  onclick="$('#form').submit();" class="btn btn-success">Сохранить</button>
                 </div>
            </div>
        </div>
    </div>
    <div class="panel-body">
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
		   <table class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td class="left" width="200">Extension</td>
				<td class="left">About</td>
				<td class="left" width="50">Parameters</td>
				<td class="right" width="100">Action</td>
              </tr>
            </thead>
            
			<tbody>
              <tr>
                <td class="left"><b>Keywords Generator</b></td>
                <td class="left"><span class="help">Keywords Generator generates meta keywords from relevant words from product(%p) and category(%c) names.<br><br>
				<b>Parameters</b><br>
				You can add keywords from product's model(%m), sku(%s), upc(%u) or brand(%b).<br>
				Available parameters: %p, %c, %m, %s and %u. Use them withat spaces or any other characters.<br>
				<b>Example: %p%c%m%u</b> - will generate keywords from product name, category name, model and product's upc.<br>				
				<i>Before generating keywords, if you have modified parameters, don't forget to save them using Save Parameters button.</i>	 </span></td>
                <td class="left"><input type="text"  class="form-control"name="parameters[keywords]" value="<?php echo $parameters['keywords'];?>" size="10"/></td>
                <td class="right">
					<?php if (file_exists(DIR_APPLICATION.'keywords_generator.php')) { ?>
					<a onclick="location = 'keywords_generator.php?token=<?php echo $this->session->data['token']; ?>'" class="btn btn-default">Generate</a>
					<?php } else { ?>
					<a onclick="alert('Keywords Generator is not installed!\nYou can purchase Keywords Generator from\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4281\nor you can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="btn btn-default" style="background:lightgrey">Generate</a>
					<?php } ?>
				</td>
              </tr>
              <tr>
                <td class="left"><b>Meta Description Generator</b></td>
                <td class="left"><span class="help"> Meta Description Generator generates meta description for products using a pattern which is set in Parameters.<br>
				The default pattern is '%p - %f' which means product's name, followed by ' - ', followed by the first sentence from product's description.<br>
				<b>Parameters</b><br>
				The are available the following parameters and they will be replaced by their actual value: <b>%p</b> - product's name, <b>%c</b> - category's name, <b>%m</b> - model, <b>%s</b> - product's sku, <b>%u</b> - product's upc, <b>%b</b> - product's brand, <b>%$</b> - product's price and <b>%f</b> - the first sentence from product's description.<br>
				<b>Example: %p (%m) - %f (by www.mysite.com)</b> - will generate the following meta description for a product called 'iPod' with model = 'iPod4': <b>iPod (iPod4) - The first sentence from iPod's description. (by www.mysite.com)</b>.<br>				
				<i>Before generating meta descriptions, if you have modified parameters, don't forget to save them using Save Parameters button.</i>
				</span></td>
                <td class="left"><input type="text"  class="form-control"name="parameters[metas]" value="<?php echo $parameters['metas'];?>" size="10"/></td>
                <td class="right">
					<?php if (file_exists(DIR_APPLICATION.'meta_description_generator.php')) { ?>
					<a onclick="location = 'meta_description_generator.php?token=<?php echo $this->session->data['token']; ?>'" class="btn btn-default">Generate</a>
					<?php } else { ?>
					<a onclick="alert('Meta Description Generator is not installed!\nYou can purchase Meta Description Generator from\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4283\nor you can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="btn btn-default" style="background:lightgrey">Generate</a>
					<?php } ?>
				</td>				
              </tr>
              <tr>
              <td class="left"><b>Product Custom Titles Generator</b></td>
                <td class="left"><span class="help">Product Custom Titles Generator generates custom titles for products from relevant keywords from product(%p) and category(%c) names.<br><br>
				<b>Parameters</b><br>
				There are available the following parameters and they will be replaced by their actual value: <b>%p</b> - product's name, <b>%c</b> - category's name, <b>%m</b> - model, <b>%s</b> - product's sku, <b>%u</b> - product's upc, <b>%b</b> - product's brand and <b>%$</b> - product's price.<br>
				<b>Example: %p (%m) by www.mysite.com</b> - will generate the following cutom title for a product called 'iPod' with model = 'iPod4': <b>iPod (iPod4) by www.mysite.com</b>.<br>				
				<i>Before generating custom titles, if you have modified parameters, don't forget to save them using Save Parameters button.</i>	
				</span></td>
                <td class="left"><input type="text"  class="form-control"name="parameters[ctitles]" value="<?php if (isset($parameters['ctitles'])) echo $parameters['ctitles'];?>" size="10"/></td>
                <td class="right">
					<?php if (file_exists(DIR_APPLICATION.'custom_title_generator.php')) { ?>
					<a onclick="location = 'custom_title_generator.php?token=<?php echo $this->session->data['token']; ?>'" class="btn btn-default">Generate</a>
					<?php } else { ?>
					<a onclick="alert('Custom Titles Generator is not installed!\nYou can purchase the whole Opencart SEO Pack PRO:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=6182');" class="btn btn-default" style="background:lightgrey">Generate</a>
					<?php } ?>
				</td>
              </tr>
              <tr>
              <td class="left"><b>Product Custom H1 Generator</b></td>
                <td class="left"><span class="help">Product Custom H1 Generator generates custom h1s for products from relevant keywords from product(%p) and category(%c) names.<br><br>
				<b>Parameters</b><br>
				There are available the following parameters and they will be replaced by their actual value: <b>%p</b> - product's name, <b>%c</b> - category's name, <b>%m</b> - model, <b>%s</b> - product's sku, <b>%u</b> - product's upc, <b>%b</b> - product's brand and <b>%$</b> - product's price.<br>
				<b>Example: %p (%m) by www.mysite.com</b> - will generate the following cutom h1 for a product called 'iPod' with model = 'iPod4': <b>iPod (iPod4) by www.mysite.com</b>.<br>				
				<i>Before generating custom h1s, if you have modified parameters, don't forget to save them using Save Parameters button.</i>	
				</span></td>
                <td class="left"><input type="text"  class="form-control"name="parameters[ch1s]" value="<?php if (isset($parameters['ch1s'])) echo $parameters['ch1s'];?>" size="10"/></td>
                <td class="right">
					<?php if (file_exists(DIR_APPLICATION.'custom_h1_generator.php')) { ?>
					<a onclick="location = 'custom_h1_generator.php?token=<?php echo $this->session->data['token']; ?>'" class="btn btn-default">Generate</a>
					<?php } else { ?>
					<a onclick="alert('Custom H1s Generator is not installed!\nYou can purchase the whole Opencart SEO Pack PRO:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=6182');" class="btn btn-default" style="background:lightgrey">Generate</a>
					<?php } ?>
				</td>
              </tr>
              <tr>
              <td class="left"><b>Product Custom Alts Generator</b></td>
                <td class="left"><span class="help">Product Custom Alts Generator generates custom alts for products from relevant keywords from product(%p) and category(%c) names.<br><br>
				<b>Parameters</b><br>
				There are available the following parameters and they will be replaced by their actual value: <b>%p</b> - product's name, <b>%c</b> - category's name, <b>%m</b> - model, <b>%s</b> - product's sku, <b>%u</b> - product's upc, <b>%b</b> - product's brand and <b>%$</b> - product's price.<br>
				<b>Example: %p (%m) by www.mysite.com</b> - will generate the following cutom alt for a product called 'iPod' with model = 'iPod4': <b>iPod (iPod4) by www.mysite.com</b>.<br>				
				<i>Before generating custom alts, if you have modified parameters, don't forget to save them using Save Parameters button.</i>	
				</span></td>
                <td class="left"><input type="text"  class="form-control"name="parameters[calts]" value="<?php if (isset($parameters['calts'])) echo $parameters['calts'];?>" size="10"/></td>
                <td class="right">
					<?php if (file_exists(DIR_APPLICATION.'custom_alt_generator.php')) { ?>
					<a onclick="location = 'custom_alt_generator.php?token=<?php echo $this->session->data['token']; ?>'" class="btn btn-default">Generate</a>
					<?php } else { ?>
					<a onclick="alert('Custom alts Generator is not installed!\nYou can purchase the whole Opencart SEO Pack PRO:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=6182');" class="btn btn-default" style="background:lightgrey">Generate</a>
					<?php } ?>
				</td>
              </tr>
              <tr>
                <td class="left"><b>Tags Generator</b></td>
                <td class="left"><span class="help">Tag Generator generates product tags from relevant keywords from product(%p) and category(%c) names.<br><br>
				<b>Parameters</b><br>
				You can add tags from product's model(%m), sku(%s) upc(%u) or brand(%b).<br>
				Available parameters: %p, %c, %m, %s and %u. Use them withat spaces or any other characters.<br>
				<b>Example: %p%c%m</b> - will generate tags from product name, category name and model.<br>				
				<i>Before generating tags, if you have modified parameters, don't forget to save them using Save Parameters button.</i>	
				</span></td>
                <td class="left"><input type="text"  class="form-control"name="parameters[tags]" value="<?php echo $parameters['tags'];?>" size="10"/></td>
                <td class="right">
					<?php if (file_exists(DIR_APPLICATION.'tag_generator.php')) { ?>
					<a onclick="location = 'tag_generator.php?token=<?php echo $this->session->data['token']; ?>'" class="btn btn-default">Generate</a>
					<?php } else { ?>
					<a onclick="alert('Tags Generator is not installed!\nYou can purchase Tags Generator from\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4165\nor you can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="btn btn-default" style="background:lightgrey">Generate</a>
					<?php } ?>
				</td>
              </tr>
              <tr>
                <td class="left"><b>Related Products Generator</b></td>
                <td class="left"><span class="help"> Related Products Generator, based on a complex algorithm, is a powerful tool which generates up to 5 related product for each product.<br><br>
				<b>Parameters</b><br>
				You can change the default number (5) of related products in parameters field for Related Products Generator. <br>
				<i>Before generating related products, if you have modified parameters, don't forget to save them using Save Parameters button.</i>				
				</span></td>
				<td class="left"><input type="text"  class="form-control"name="parameters[related]" value="<?php echo $parameters['related'];?>" size="10"/></td>
                <td class="right">
					<?php if (file_exists(DIR_APPLICATION.'rp_generator.php')) { ?>
					<a onclick="location = 'rp_generator.php?token=<?php echo $this->session->data['token']; ?>'" class="btn btn-default">Generate</a>
					<?php } else { ?>
					<a onclick="alert('Related Products Generator is not installed!\nYou can purchase Related Products Generator from\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4593\nor you can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="btn btn-default" style="background:lightgrey">Generate</a>
					<?php } ?>					
				</td>
              </tr>
              <tr>
                <td class="left"><b>SEO Urls Generator</b></td>
                <td class="left"><span class="help"> SEO URLS Generator generates SEO URLS for products, categories, manufacturers and information. 
				<b>Parameters</b><br>
				You can change the default extension (.html) of generated urls. <br>
				<i>Before generating SEO URLs, if you have modified parameters, don't forget to save them using Save Parameters button.</i></span></td>
				<td class="left"><input type="text"  class="form-control" name="parameters[ext]" value="<?php if (isset($parameters['ext'])) {echo $parameters['ext'];} ?>" size="10"/></td>
                <td class="right">
					<?php if ($seourls) { ?>
					<a onclick="location = '<?php echo $seourls; ?>'" class="btn btn-default">Generate</a>
					<?php } else { ?>
					<a onclick="alert('SEO Urls Generator is not installed!\nYou can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="btn btn-default" style="background:lightgrey">Generate</a>
					<?php } ?>					
				</td>
              </tr>
              <tr>
                <td class="left"><b>SEO Friendly Urls Generator</b></td>
                <td class="left"><span class="help"> SEO Friendly URLs Generator transforms non-SEO friendly links like:<br>
				<i>yoursite.com/index.php?route=account/login</i><br>
				into SEO friendly links:<br>
				<i>yoursite.com/login</i></span></td>
                <td class="right" colspan="2">
					<?php if ($friendlyurls) { ?>
					<a onclick="location = '<?php echo $friendlyurls; ?>'" class="btn btn-default">Generate</a>
					<?php } else { ?>
					<a onclick="alert('SEO Friendly Urls Generator is not installed!\nYou can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="btn btn-default" style="background:lightgrey">Generate</a>
					<?php } ?>					
				</td>
              </tr>
              <tr>
                <td class="left"><b>Clear SEO</b></td>
                <td class="left">
					<span class="help"> With Clear SEO you can easily delete ALL:<br><br>
					- product tags<br>
					- meta descriptions<br>
					- meta keywords<br>
					- seo urls<br>
					- related products<br>
					<br>
					<span style="color:red">A database backup is recommended before using Clear SEO, because you may lose SEO data!</span><br>
					</span></td>
                <td class="right" colspan="2">
                    <div class="button-group">
    					 <button type="button"  onclick="clearseo('Products Keywords', '<?php echo $clearkeywords; ?>');" class="btn btn-default" >Clear Keywords</button>
    					 <button type="button"  onclick="clearseo('Products Meta Descriptions', '<?php echo $clearmetas; ?>');" class="btn btn-default" >Clear Meta Description</button>
    					 <button type="button"  onclick="clearseo('Product Custom Titles', '<?php echo $cleartitles; ?>');" class="btn btn-default" >Clear Custom Titles</button>
    					 <button type="button"  onclick="clearseo('Product Custom H1s', '<?php echo $clearh1s; ?>');" class="btn btn-default" >Clear Custom H1s</button>
    					 <button type="button"  onclick="clearseo('Product Custom Alts', '<?php echo $clearalts; ?>');" class="btn btn-default" >Clear Custom Alts</button>
    					 <button type="button"  onclick="clearseo('Products Tags', '<?php echo $cleartags; ?>');" class="btn btn-default" >Clear Tags</button>
    					 <button type="button"  onclick="clearseo('SEO Urls', '<?php echo $clearurls; ?>');" class="btn btn-default" >Clear SEO Urls</button>
    					 <button type="button"  onclick="clearseo('Related Products', '<?php echo $clearproducts; ?>');" class="btn btn-default" >Clear Related Products</button>
					</div>    
				</td>
              </tr>
              <tr>
                <td class="left" colspan="2">
				Auto create SEO URLS for products/categories/brands/info on insert if seo urls don't exist				
				</td>
				<td class="right" colspan="2">
				<?php if ((isset($parameters['autourls'])) && ($parameters['autourls'])) { ?>
                <input type="radio" name="parameters[autourls]" value="1" checked="checked" /> Yes                
                <input type="radio" name="parameters[autourls]" value="0" /> No
                <?php } else { ?>
                <input type="radio" name="parameters[autourls]" value="1" /> Yes
                <input type="radio" name="parameters[autourls]" value="0" checked="checked" /> No
                <?php } ?>
				</td>
			  </tr>
			  <tr>
                <td  class="left" colspan="2">
				Auto create Meta Keywords for products on insert if meta keywords don't exist
				</td>
				<td class="right" colspan="2">
				<?php if ((isset($parameters['autokeywords'])) && ($parameters['autokeywords'])) { ?>
                <input type="radio" name="parameters[autokeywords]" value="1" checked="checked" /> Yes                
                <input type="radio" name="parameters[autokeywords]" value="0" /> No
                <?php } else { ?>
                <input type="radio" name="parameters[autokeywords]" value="1" /> Yes
                <input type="radio" name="parameters[autokeywords]" value="0" checked="checked" /> No
                <?php } ?>
				</td>
			  </tr>
			  <tr>
                <td class="left" colspan="2">
				Auto create Meta Descriptions for products on insert if meta descriptions don't exist
				</td>
				<td class="right" colspan="2">
				<?php if ((isset($parameters['autometa'])) && ($parameters['autometa'])) { ?>
                <input type="radio" name="parameters[autometa]" value="1" checked="checked" /> Yes                
                <input type="radio" name="parameters[autometa]" value="0" /> No
                <?php } else { ?>
                <input type="radio" name="parameters[autometa]" value="1" /> Yes
                <input type="radio" name="parameters[autometa]" value="0" checked="checked" /> No
                <?php } ?>
				</td>
			  </tr>
			  <tr>
                <td class="left" colspan="2">
				Auto create Tags for products on insert if tags don't exist
				</td>
				<td class="right" colspan="2">
				<?php if ((isset($parameters['autotags'])) && ($parameters['autotags'])) { ?>
                <input type="radio" name="parameters[autotags]" value="1" checked="checked" /> Yes                
                <input type="radio" name="parameters[autotags]" value="0" /> No
                <?php } else { ?>
                <input type="radio" name="parameters[autotags]" value="1" /> Yes
                <input type="radio" name="parameters[autotags]" value="0" checked="checked" /> No
                <?php } ?>
				</td>
			  </tr>			  
            </tbody>
          </table>
	</form>
	</div>
   </div>
</div>
<script>
var isCtrl = false;
$(document).keyup(function (e) {
 if(e.which == 17) isCtrl=false;
}).keydown(function (e) {
    if(e.which == 17) isCtrl=true;
    if(e.which == 83 && isCtrl == true) {
        $('#content > div > div.panel-heading > div > div > div > button').trigger('click');
    return false;
 }
});
</script>
<?php echo $footer; ?>