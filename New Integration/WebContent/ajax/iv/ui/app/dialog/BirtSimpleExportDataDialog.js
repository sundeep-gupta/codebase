/******************************************************************************
 *	Copyright (c) 2004 Actuate Corporation and others.
 *	All rights reserved. This program and the accompanying materials 
 *	are made available under the terms of the Eclipse Public License v1.0
 *	which accompanies this distribution, and is available at
 *		http://www.eclipse.org/legal/epl-v10.html
 *	
 *	Contributors:
 *		Actuate Corporation - Initial implementation.
 *****************************************************************************/
 
/**
 *	Birt export report dialog.
 */
BirtSimpleExportDataDialog = Class.create( );

BirtSimpleExportDataDialog.prototype = Object.extend( new BirtDialogBase( ),
{
	__neh_select_change_closure : null,
	__neh_switchResultSet_closure : null,
	
	availableResultSets : [],
	selectedColumns : [],

	/**
	 *	Initialization routine required by "ProtoType" lib.
	 *	@return, void
	 */
	__initialize : function( id )
	{
		this.__neh_switchResultSet_closure = this.__neh_switchResultSet.bindAsEventListener( this );
		this.__neh_click_exchange_closure = this.__neh_click_exchange.bindAsEventListener( this );
		this.__cb_installEventHandlers( id );
	},
	
	/**
	 *	Install native/birt event handlers.
	 *
	 *	@id, toolbar id (optional since there is only one toolbar)
	 *	@return, void
	 */
	__installEventHandlers : function( id )
	{
		var oSelects = this.__instance.getElementsByTagName( 'select' );
		Event.observe( oSelects[0], 'change', this.__neh_switchResultSet_closure, false );
		
		// Initialise exchange buttons
		var oInputs = this.__instance.getElementsByTagName( 'input' );
		for ( var i = 0; i < oInputs.length - 2; i++ )
		{
			Event.observe( oInputs[i], 'click', this.__neh_click_exchange_closure, false );
		}
	},
	
	/**
	 *	Native event handler for selection item movement.
	 */
	__neh_click_exchange : function( event )
	{
		var oInputs = this.__instance.getElementsByTagName( 'input' );
		var oSelects = this.__instance.getElementsByTagName( 'select' );
		
		switch ( Event.element( event ).name )
		{
			case 'Addall':
			{
				if ( oSelects[1].options.length  > 0 )
				{
					this.moveAllItems( oSelects[1], oSelects[2] );
				}
				break;
			}
			case 'Add':
			{
				if ( oSelects[1].options.length  > 0 )
				{
					this.moveSingleItem( oSelects[1], oSelects[2] );
				}
				break;
			}
			case 'Remove':
			{
				if ( oSelects[2].options.length  > 0 )
				{
					this.moveSingleItem( oSelects[2], oSelects[1] );
				}
				break;
			}
			case 'Removeall':
			{
				if ( oSelects[2].options.length  > 0 )
				{
					this.moveAllItems( oSelects[2], oSelects[1] );
				}
				break;
			}
		}
		
		this.__updateButtons( );
	},
	
	/**
	 *	Update button status.
	 */
	__updateButtons : function( )
	{
		var oSelects = this.__instance.getElementsByTagName( 'select' );
		var canAdd = oSelects[1].options.length > 0;
		var canRemove = oSelects[2].options.length  > 0;

		var oInputs = this.__instance.getElementsByTagName( 'input' );
		
		oInputs[0].src = canAdd ? "images/iv/AddAll.gif" : "images/iv/AddAll_disabled.gif";
		oInputs[0].style.cursor = canAdd ? "pointer" : "default";
		
		oInputs[1].src = canAdd ? "images/iv/Add.gif" : "images/iv/Add_disabled.gif";
		oInputs[1].style.cursor = canAdd ? "pointer" : "default";
		
		oInputs[2].src = canRemove ? "images/iv/Remove.gif" : "images/iv/Remove_disabled.gif";
		oInputs[2].style.cursor = canRemove ? "pointer" : "default";

		oInputs[3].src = canRemove ? "images/iv/RemoveAll.gif" : "images/iv/RemoveAll_disabled.gif";
		oInputs[3].style.cursor = canRemove ? "pointer" : "default";
	},
	
	/**
	 *	Move single selection item.
	 */
	moveSingleItem : function( sel_source, sel_dest )
	{
		if ( sel_source.selectedIndex == -1 )
		{
			return;
		}
		
     	var SelectedText = sel_source.options[sel_source.selectedIndex].text;
     	var SelectedValue = sel_source.options[sel_source.selectedIndex].value;
   		var newOption = new Option( SelectedText );
		newOption.value = SelectedValue;
   		sel_dest.options.add( newOption );
		sel_dest.selectedIndex = sel_dest.options.length - 1;
   		
   		sel_source.options[sel_source.selectedIndex] = null;
   		sel_source.selectedIndex = 0;
	},
	
	/**
	 *	Move all selection items.
	 */
	moveAllItems : function( sel_source, sel_dest )
	{
   		for ( var i = 0; i < sel_source.length; i++ )
   		{
     		var SelectedText = sel_source.options[i].text;
     		var SelectedValue = sel_source.options[i].value;
	   		var newOption = new Option( SelectedText );
			newOption.value = SelectedValue;
     		sel_dest.options.add( newOption );
   		}
   		
   		sel_dest.selectedIndex = 0;
   		sel_source.length = 0;
	},	

	/**
	 *	Binding data to the dialog UI. Data includes zoom scaling factor.
	 *
	 *	@data, data DOM tree (schema TBD)
	 *	@return, void
	 */
	 __bind : function( data )
	 {
	 	if ( !data )
	 	{
	 		return;
	 	}
	 	
	 	var oSelects = this.__instance.getElementsByTagName( 'select' );
		oSelects[0].options.length = 0;
		oSelects[1].options.length = 0;
		oSelects[2].options.length = 0;
		
		this.availableResultSets = [];
	 	
	 	var resultSets = data.getElementsByTagName( 'ResultSet' );
	 	for ( var k = 0; k < resultSets.length; k++ )
	 	{
	 		var resultSet = resultSets[k];
	 		
		 	var queryNames = resultSet.getElementsByTagName( 'QueryName' );
			oSelects[0].options.add( new Option( queryNames[0].firstChild.data ) );
				 	
			this.availableResultSets[k] = {};
			
		 	var columns = resultSet.getElementsByTagName( 'Column' );
		 	for( var i = 0; i < columns.length; i++ )
		 	{
		 		var column = columns[i];
		 		
		 		var columnName = column.getElementsByTagName( 'Name' );
		 		var label = column.getElementsByTagName( 'Label' );
				this.availableResultSets[k][label[0].firstChild.data] = columnName[0].firstChild.data;
		 	}
		}
		
		this.__neh_switchResultSet( );
	 },
	 
	 /**
	  *	switch result set.
	  */
	 __neh_switchResultSet : function( )
	 {
	 	var oSelects = this.__instance.getElementsByTagName( 'select' );
		oSelects[1].options.length = 0;
		oSelects[2].options.length = 0;	
	 	
	 	var columns = this.availableResultSets[oSelects[0].selectedIndex];
	 	for( var label in columns )
	 	{
	 		var colName = columns[label];
			var option = new Option( label );
			option.value = colName;
			oSelects[1].options.add( option );
	 	}
	 	
		this.__updateButtons( );
	 },

	/**
	 *	Handle clicking on ok.
	 *
	 *	@event, incoming browser native event
	 *	@return, void
	 */
	__okPress : function( )
	{
		var oSelects = this.__instance.getElementsByTagName( 'select' );
		this.__l_hide( );
		if ( oSelects[2].options.length > 0 )
		{
			for( var i = 0; i < oSelects[2].options.length; i++ )
			{
				this.selectedColumns[i] = oSelects[2].options[i].value;
			}
			
			this.__constructForm( );
		}
	},
	
	/**
	 *	Construct extract data form. Post it to server.
	 */
	__constructForm : function( )
	{
		var dialogContent = $( 'simpleExportDialogBody' );
		var hiddenDiv = document.createElement( 'div' );
		hiddenDiv.style.display = 'none';

		var hiddenForm = document.createElement( 'form' );
		hiddenForm.method = 'post';
		hiddenForm.target = '_self';
		var url = document.location.href;
		var index = url.indexOf( "frameset" );
		url = url.substring( 0, index ) + "download" + url.substring( index + 8, url.length - 1 );
		hiddenForm.action = url;
		
		// Pass over current element's iid.
		var queryNameInput = document.createElement( 'input' );
		queryNameInput.type = 'hidden';
		queryNameInput.name = "ResultSetName";
		var oSelects = this.__instance.getElementsByTagName( 'select' );
		queryNameInput.value = oSelects[0].options[oSelects[0].selectedIndex].text;
		hiddenForm.appendChild( queryNameInput );

		// Total # of selected columns.
		if ( this.selectedColumns.length > 0 )
		{
			var hiddenSelectedColumnNumber = document.createElement( 'input' );
			hiddenSelectedColumnNumber.type = 'hidden';
			hiddenSelectedColumnNumber.name = "SelectedColumnNumber";
			hiddenSelectedColumnNumber.value = this.selectedColumns.length;
			hiddenForm.appendChild( hiddenSelectedColumnNumber );

			// data of selected columns.
			for( var i = 0; i < this.selectedColumns.length; i++ )
			{
				var hiddenSelectedColumns = document.createElement( 'input' );
				hiddenSelectedColumns.type = 'hidden';
				hiddenSelectedColumns.name = "SelectedColumn" + i;
				hiddenSelectedColumns.value = this.selectedColumns[i];
				hiddenForm.appendChild( hiddenSelectedColumns );
			}
		}
		
		this.selectedColumns = [];
		
		var tmpSubmit = document.createElement( 'input' );
		tmpSubmit.type = 'submit';
		tmpSubmit.value = 'TmpSubmit';
		hiddenForm.appendChild( tmpSubmit );
		
		hiddenDiv.appendChild( hiddenForm );
		dialogContent.appendChild( hiddenDiv );
		tmpSubmit.click( );
		dialogContent.removeChild( hiddenDiv );
	}
} );