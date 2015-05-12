<div class="menu-edit-form">
	<div class="names">
		<ul class="nav nav-tabs">
			<?php $li = 0; ?>
			<?php foreach ($languages as $language) { ?>
			<li class="<?php if(!$li) { ?>active<?php } ?>">
				<a href="#tab-names-<?php print $language['language_id']; ?>" data-toggle="tab">
					<img src="view/image/flags/<?php print $language['image']; ?>" title="<?php print $language['name']; ?>"> <?php print $language['name']; ?>
				</a>
			</li>
			<?php $li++; ?>
			<?php } ?>
		</ul>
		<div class="tab-content">
			<?php $li = 0; ?>
			<?php foreach ($languages as $language) { ?>
			<div class="element-descriptions tab-pane <?php if(!$li) { ?>active<?php } ?>" id="tab-names-<?php print $language['language_id']; ?>" language-id="<?php print $language['language_id']?>">
				<div class="form-group row">
					<label class="col-xs-3 control-label"><?php print $entry_element_name; ?></label>
					<div class="col-xs-9">
						<input type="text" value="" class="form-control element-name" language-name="<?php print $language['name']; ?>">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-xs-3 control-label"><?php print $entry_element_description; ?></label>
					<div class="col-xs-9">
						<textarea class="form-control element-description"></textarea>
					</div>
				</div>
			</div>
			<?php $li++; ?>
			<?php } ?>
			<div class="form-group row">
				<label class="col-xs-3 control-label"><?php print $entry_element_class; ?></label>
				<div class="col-xs-9">
					<input type="text" value="" class="form-control element-class">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-xs-3 control-label"><?php print $entry_element_icon; ?></label>
				<div class="col-xs-9">
					<img class="thumbnail col-sm-4" 
					id="element-icon"
					src="/image/no_image.jpg"
					style="width: 40px;height: 40px;">
					<form class="col-sm-10" action="<?php print $this->url->link('module/oc_menu/uploadIcon', 'token=' . $this->session->data['token']); ?>" method="post" enctype="multipart/form-data" id="icon-uploader">
						<input type="file" id="element-icon-file" name="element_icon_file">
                        <br>
                        <button class="btn btn-danger" id="clear-image">Очистить</button>
					</form>
					<input type="hidden" value="" class="form-control element-icon" id="element-icon-value">
				</div>

			</div>
			<div class="form-group row">
				<label class="col-xs-3 control-label"><?php print $entry_element_status; ?></label>
				<div class="col-xs-9">
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-success active">
							<i class="fa fa-check"></i>
							<input type="radio" value="1" name="element_status" checked class="element-status">
							<?php print $text_enabled; ?>
						</label>
						<label class="btn btn-danger"> 
							<i class="fa fa-times"></i>
							<input type="radio" value="0" name="element_status" class="element-status">
							<?php print $text_disabled; ?>
						</label>
					</div>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-xs-3 control-label"><?php print $entry_element_type; ?></label>
				<div class="col-xs-9">
					<select class="form-control element-type">
						<?php foreach ($types as $type) { ?>
						<option value="<?php print $type['type_id'];  ?>" type-key="<?php print $type['type_key']; ?>"><?php print $type['name']; ?></option>
						<?php } ?>
					</select>
				</div>
			</div>
			<?php $ti = 0;?>
			<?php foreach ($types as $type) { ?>
			<div class="form-group row element-type-properties <?php if($ti) { ?>hidden<?php } ?> <?php print $type['type_key']; ?>">
				<div class="col-xs-3">
				</div>
				<div class="col-xs-9">
					<?php if(!empty($type['properties'])) { ?>
					<?php foreach ($type['properties'] as $prop) { ?>
					<div class="row element-type-property" prop-name="<?php print $prop['property_key']; ?>" type-key="<?php print $type['type_key']; ?>">
						<label class="col-xs-4 control-label"><?php print $prop['name']; ?></label>
						<div class="col-xs-8">
							<input type="text" value="" class="form-control element-type-property-value">
							<div class="row element-type-property-result">
								<?php if(!$ti) { ?>
								<input type="hidden" value="" class="type-category-id">
								<div class="type-category-text"></div>
								<?php } ?>
							</div>
						</div>
					</div>
					<?php } ?>
					<?php } ?>
				</div>
			</div>
			<?php $ti++; ?>
			<?php } ?>
			<div class="form-group row element-columns">
				<label class="col-xs-3 control-label"><?php print $entry_element_column_quantity; ?></label>
				<div class="col-xs-3">
					<input type="number" value="1" class="form-control element-column-quantity" min="1" max="10">
				</div>
				<div class="col-xs-6 element-columns-data">
					<div class="form-group element-column-data" column-number="1" column-id="0">
						<div class="row">
							<label class="col-xs-4 control-label"><?php print $entry_element_column_width; ?></label>
							<div class="col-xs-8">
								<input type="text" value="" name="element-column-width" class="form-control element-column-width">
							</div>
						</div>
						<div class="row">
							<label class="col-xs-4 control-label"><?php print $entry_element_column_style; ?></label>
							<div class="col-xs-8">
								<textarea name="element-column-style" class="form-control element-column-style"></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>