<?php echo $header; ?>
<div id="content" class="container">
  <ul class="breadcrumb">
    <li><a href="<?php print $this->url->link('common/home', 'token=' . $this->session->data['token']); ?>">Главная</a></li>
    <li><a href="<?php print $this->url->link('catalog/series', 'token=' . $this->session->data['token']); ?>">Серии продуктов</a></li>
    <li><a href="<?php print $this->url->link('catalog/series/update', 'series_id=' . (int)$this->request->get['series_id'] . '&token=' . $this->session->data['token']); ?>"><?php print $series_name; ?></a></li>
  </ul>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="pull-right"></div>
      <h1 class="panel-title"><i class="fa fa-list"></i> Серии продуктов </h1>
    </div>
    <div class="panel-body">
      
        <div class="table-responsive">
          <table class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-center">
                Изображение
                </td>
                <td class="text-center">
                Название  
                </td>
                <td class="text-center">
                Артикул
                </td>
                <td class="text-center">
                Действие  
                </td>
                
            </thead>
            <tbody>
            	<tr>
                    <td colspan="3" class="text-left">
              			<span>
              				<input class="form-control" type="name" value="" id="product_name" name="product_name" style="width: 100%;">
              				<input type="hidden" name="product_id" value="0">
              				<input type="hidden" name="series_id" value="<?php print (int)$this->request->get['series_id']; ?>">
              			</span>
              		</td>  	
                    <td class="text-right">
              			<span>
              				<a id="addProduct" class="btn btn-success" style="width: 100%;">
              					<i class="fa fa-plus"></i>
              					Прикрепить
              				</a>
              			</span>
              		</td>  
              	</tr>
            	<?php if(isset($products)) { ?>
            	<?php foreach ($products as $product) { ?>
                <tr product-id="<?php print $product['product_id']; ?>" class="product_record">
                    <td class="text-left">
              			<span>
              				<a href="<?php print $product['href']; ?>">
              					<img src="<?php print $product['image']; ?>" />
              				</a>
              			</span>
              		</td>  
                    <td class="text-left">
              			<span>
              				<a href="<?php print $product['href']; ?>">
              					<?php print $product['name']; ?>
              				</a>
              			</span>
              		</td>  
                    <td class="text-left">
              			<span>
              				<a href="<?php print $product['href']; ?>">
              					<?php print $product['model']; ?>
              				</a>
              			</span>
              		</td>  
                    <td class="text-right">
              			<span>
              				<a href="<?php print $product['delete']; ?>" class="btn btn-danger removeProduct">
              					<i class="fa fa-trash-o"></i>
              					Открепить
              				</a>
              			</span>
              		</td>  
              	</tr>
              	<?php } ?>
              	<?php } ?>
            </tbody>
          </table>
        </div>
    </div>
  </div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	/* Autocomplete */
	$('#product_name').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/product/autocomplete&filter_status=1&token=<?php echo $this->session->data['token']; ?>&filter_name=' +  encodeURIComponent(request),
				dataType: 'json',			
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['name'],
							value: item['product_id']
						}
					}));
				}
			});
		},
		'select': function(item) {
			$('#product_name').val(item.label);
			$('input[name=product_id]').val(item.value);
		}	
	});

	/* Save product */
	$('#addProduct').on('click', function(){
		var product_id = $('input[name=product_id]').val();
		var series_id = $('input[name=series_id]').val();
		var data = {
			product_id: product_id,
			series_id: series_id
		};
		$.ajax({
			url: '<?php print html_entity_decode($add_product_href); ?>',
			data: data,
			dataType: 'json',
			type: 'post',
			beforeSend: function(){
				console.log('show preloader');
			},
			complete: function(){
				console.log('hide preloader');
			},
			success: function(response){
				if(response.error.length == 0) {
					if(response.message.length > 0) {
						$(response.message).each(function(){
							showSuccessMessage(this);
						});
					}
					setTimeout(function(){
						window.location.reload();
					}, 1500);
				} else {
					$(response.error).each(function(){
						showErrorMessage(this);
					});
				}
			},
			error: function(e1, e2){
				console.log(e1);
				console.log(e2);
			}
		});
		
	});
	$('.removeProduct').on('click', function(e){
		var url = $(this).attr('href');
		confirm('Вы уверены?', function(confirm){
			if(confirm) {
				$.ajax({
					url: url,
					dataType: 'json',
					type: 'post',
					beforeSend: function(){
						console.log('show preloader');
					},
					complete: function(){
						console.log('hide preloader');
					},
					success: function(response){
						if(response.error.length == 0) {
							if(response.message.length > 0) {
								$(response.message).each(function(){
									showSuccessMessage(this);
								});
							}
							setTimeout(function(){
								window.location.reload();
							}, 1500);
						} else {
							$(response.error).each(function(){
								showErrorMessage(this);
							});
						}
					},
					error: function(e1, e2){
						console.log(e1);
						console.log(e2);
					}
				});
			}
		});
		
		e.preventDefault();
		return false;
	});
}); 
</script> 
<?php echo $footer; ?>