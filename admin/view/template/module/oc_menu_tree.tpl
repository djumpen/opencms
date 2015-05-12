<?php

/*
 * Care, if u want to change template of node element than u need to change it in JS to!!!
 * */
if(!function_exists('showMenuTree')){
	function showMenuTree($tree){
		if(!empty($tree)) {
			foreach ($tree as $node) { 
			?>
			<li 
				class="node level-<?php print $node['level']; ?> <?php if(!empty($node['childrens'])){ ?>tree<?php } ?>" 
				node-id="<?php print $node['menu_id'];?>" 
				node-tmp-id="0"
				node-type="<?php print $node['type_id']; ?>"
				>
				<div class="node-info">
					<span 
						class="type <?php print $node['type_icon']; ?>" 
						title="<?php print $node['type']; ?>" 
						data-toggle="tooltip">
						
					</span>
					<span 
						class="name"
						title="<?php print $node['description']; ?>" 
						data-toggle="tooltip">
						<?php print $node['name']; ?>
					</span>
					<div class="actions pull-right">
						<div class="edit fa fa-edit" node-id="<?php print $node['menu_id']; ?>"></div>
						<div class="delete fa fa-times" node-id="<?php print $node['menu_id']; ?>"></div>
					</div>
				</div>
				<ul class="node-container">
				<?php if(!empty($node['childrens'])) { ?>
					<?php showMenuTree($node['childrens']); ?>
				<?php } ?>
				</ul>
			</li>
			<?php 	
			}
		}
	}
}
?>
<div class="menu-edit-list text-center" group-id="<?php print $group_id; ?>">
	<div class="inner-wrapper text-left">
		<ul class="node-container">
			<?php showMenuTree($tree); ?>
		</ul>
	</div>
</div>