<?php

class HTMLTable {
    protected $table_attr;
    protected $header_row;
    protected $rows;
    protected $row_index;
    public function __construct($attr = '') {
	if ($attr != '') {
	    $this->table_attr = $attr;
	}
	$this->row_index = -1;
	$this->rows = array();
    }

    public function add_column( $col_attr = null, 
				$col_data = null, $row_index = null) {

	$col = new TableColumn($col_attr, $col_data);

	if ($row_index != null) {
	    $this->row_index = $row_index;
	}
	$this->rows[$this->row_index]->add_column($col);
    }
    public function add_header_column ($col_attr = null,
				       $col_data = null) {
	
	$col = new TableHeader($col_attr, $col_data);
	$this->header_row->add_column($col);
    }
    public function add_header_row($row_attr = null) {
	$this->header_row = new TableRow($row_attr);
    }

    public function add_row($row_attr = null) {
	$row = new TableRow($row_attr);
	array_push($this->rows, $row);
	$this->row_index++;
    }

    public  function get_html_text() {
	$table_text = '<table ';
	if ( $this->table_attr != null) {
	    foreach ($this->table_attr as $key=>$value) {
		$table_text .= $key."='".$value."'";
	    }
	}
	$table_text .= ">\n";
	
	if ($this->header_row != null) {
	    $table_text .= $this->header_row->get_html_text();
	}

	if ($this->rows != null) {
	    foreach($this->rows as $row) {
		$table_text .= $row->get_html_text();
	    }
	}
	$table_text .= '</table>';
	return $table_text;
    }
}


class TableRow {

    protected $row_attr;
    protected $cols;

    public function __construct($row_attr = null) {
	if ($row_attr != null) {
	    $this->row_attr = $row_attr;
	}
	$this->cols = array();
    }

    public function add_column($col = null) {
	if ($col != null) {
	    array_push($this->cols, $col);
	}
    }

    public function get_html_text() {
	$row_text = '<tr ';
	if ($this->row_attr != null) {
	    foreach($this->row_attr as $key => $value) {
		$row_text .= $key."='".$value."'";
	    }
	}
	$row_text .= ">\n";
	if ($this->cols != null) {
	    foreach($this->cols as $col) {
		$row_text .= $col->get_html_text();
	    }
	}
	$row_text .= '</tr>';
	return $row_text;
    }
}

class TableColumn {
    protected $col_attr;
    protected $col_data;

    public function __construct($col_attr = null, $col_data = null) {
	if($col_attr != null)
	{
	    $this->col_attr = $col_attr;
	}
	
	if($col_data != null) {
	    $this->col_data = $col_data;
	}
    }
    
    public function get_html_text() {
	$col_text = '<td ';

	if($this->col_attr != null) {
	    foreach($this->col_attr as $key => $value) {
		$col_text .= $key."='".$value."'";
	    }	    
	}

	$col_text .= ">\n";
	if(isset($this->col_data) and is_string($this->col_data)) {
	    $col_text .= $this->col_data;
	} elseif(isset($this->col_data)) {
	    $col_text .= $this->col_data->get_html_text();
	}
	$col_text .= "</td>\n";
	return $col_text;
    }

}
class TableHeader {
    protected $col_attr;
    protected $col_data;

    public function __construct($col_attr = null, $col_data = null) {
	if($col_attr != null)
	{
	    $this->col_attr = $col_attr;
	}
	
	if($col_data != null) {
	    $this->col_data = $col_data;
	}
    }
    
    public function get_html_text() {
	$col_text = '<th ';

	if($this->col_attr != null) {
	    foreach($this->col_attr as $key => $value) {
		$col_text .= $key."='".$value."'";
	    }	    
	}

	$col_text .= ">\n";
	if(isset($this->col_data) and is_string($this->col_data)) {
	    $col_text .= $this->col_data;
	} elseif(isset($this->col_data)) {
	    $col_text .= $this->col_data->get_html_text();
	}
	$col_text .= "</th>\n";
	return $col_text;
    }

}
?>