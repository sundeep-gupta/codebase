<?php defined('_JEXEC') or die('Restricted access'); ?>

<form action="index.php?option=com_movielister&amp;task=display" method="post" name="adminForm">

	<table>
		<tr>
			<td align="left" width="100%">
				<?php echo JText::_( 'Filter' ); ?>:
				<input type="text" name="search" id="search" value="<?php echo $this->lists['search'];?>" class="text_area" onchange="document.adminForm.submit();" />
				<button onclick="this.form.submit();"><?php echo JText::_( 'Go' ); ?></button>
				<button onclick="document.getElementById('search').value='';this.form.getElementById('levellimit').value='10';this.form.getElementById('filter_state').value='';this.form.submit();"><?php echo JText::_( 'Reset' ); ?></button>
			</td>
			<td nowrap="nowrap">
				<?php
				echo JText::_( 'Max Levels' );
				echo $this->lists['levellist'];
				echo $this->lists['state'];
				?>
			</td>
		</tr>
  	</table>
<table class="adminlist">
	<thead>
		<tr>
			<th width="20">
				<?php echo JText::_( 'NUM' ); ?>
			</th>
			<th width="20">
				<input type="checkbox" name="toggle" value="" onclick="checkAll(<?php echo count($this->items); ?>);" />
			</th>
			<th width="10% class="title">
				<?php echo JText::_('Subscription ID'); ?>
			</th>
			<th width="30" class="title">
				<?php echo JText::_('User ID');   ?>
			</th>
			<th width="20%" class="title">
				<?php echo JText::_('User Name'); ?>
			</th>
			<th width="20%" nowrap="nowrap">
				<?php echo JText::_('Start Date');  ?>
			</th>
      		<th width="120">
				<?php echo JText::_('End Date');  ?>
			</th>
      		<th width="25%">
				<?php echo JText::_('Remarks');  ?>
			</th>

		</tr>
	</thead>
	<tbody>
	</tbody>
	</table>

	<input type="hidden" name="option" value="com_menus" />
	<input type="hidden" name="task" value="view" />
	<input type="hidden" name="boxchecked" value="0" />
	<input type="hidden" name="filter_order" value="<?php echo $this->lists['order']; ?>" />
	<input type="hidden" name="filter_order_Dir" value="<?php echo $this->lists['order_Dir']; ?>" />
</form>

