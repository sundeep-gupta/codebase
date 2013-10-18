<?php

	// ==================================================================
	//  Author:  Justin Vincent (justin@visunet.ie)
	//	Web: 	 http://php.justinvincent.com
	//	Name: 	 ezSQL
	// 	Desc: 	 Class to make it very easy to deal with mySQL database connections.
    //  License: FREE / Donation (LGPL - You may do what you like with ezSQL - no exceptions.)
	//
	// !! IMPORTANT !!
	//
	//  Please send me a mail telling me what you think of ezSQL
	//  and what your using it for!! Cheers. [ justin@visunet.ie ]
	//
	// ==================================================================
    //
    // NOTE: The original version of this php class used the old mysql functions.
    //       I have modified the code to use the mysqli (improved) functions for 
    //       use with php 5.
    //
    // Modified By:   Author: Jason Smallcanyon
    // Last Modified: $Date: 2005/09/28 23:31:11 $
    // Revision:      $Revision: 1.1.1.1 $
    // Source:        $Source: /cvsroot/orbitaldata/control/php-lib/modules/database.php,v $
    //
	// ==================================================================

	//	ezSQL Constants
	define("EZSQL_VERSION", "1.21");
	define("OBJECT", "OBJECT", true);
	define("ARRAY_A", "ARRAY_A", true);
	define("ARRAY_N", "ARRAY_N", true);


	class db
	{


		function db($dbuser, $dbpassword, $dbname, $dbhost)
		{
			$this->dbh = @mysqli_connect($dbhost,$dbuser,$dbpassword);
			if(!$this->dbh) {
				trigger_error("Error establishing a database connection!", E_USER_ERROR);
            }
			$this->select($dbname);
		}

		function select($db)
		{
			if(!@mysqli_select_db($this->dbh, $db)) {
				trigger_error("Error selecting database!", E_USER_ERROR);
            }
		}

		function escape($str)
		{
			return mysqli_escape_string(stripslashes($str));
		}

		function flush()
		{
			$this->last_result 	= null;
			$this->col_info 	= null;
			$this->last_query 	= null;
		}

		function query($query)
		{
			// Flush cached values..
			$this->flush();

			// Log how the function was called
			$this->func_call = "\$db->query(\"$query\")";

			// Keep track of the last query for debug..
			$this->last_query = $query;

			// Perform the query via std mysql_query function..
			$this->result = mysqli_query($this->dbh, $query);

			// If there was an insert, delete or update see how many rows were affected
			// (Also, If there there was an insert take note of the insert_id
			$query_type = array("insert", "delete", "update", "replace");

			// loop through the above array
			foreach($query_type as $word)
			{
				// This is true if the query starts with insert, delete or update
				if ( preg_match("/^\\s*$word /i",$query) )
				{
					$this->rows_affected = mysqli_affected_rows();

					// This gets the insert ID
					if ( $word == "insert" || $word == "replace" )
					{
						$this->insert_id = mysqli_insert_id($this->dbh);
					}

					$this->result = false;
				}
			}

			if(mysqli_error())
				trigger_error(mysqli_error(), E_USER_ERROR);
			else
			{
				// In other words if this was a select statement..
				if($this->result)
				{
					// =======================================================
					// Take note of column info
					$i = 0;
					while ($i < @mysqli_num_fields($this->result))
					{
						$this->col_info[$i] = @mysqli_fetch_field($this->result);
						$i++;
					}

					// =======================================================
					// Store Query Results

					$i = 0;
					while($row = @mysqli_fetch_object($this->result))
					{
						// Store relults as an objects within main array
						$this->last_result[$i] = $row;
						$i++;
					}

					// Log number of rows the query returned
					$this->num_rows = $i;

					@mysqli_free_result($this->result);

					// If there were results then return true for $db->query
					return ($i) ? true : false;
				}
				else
				{
					// Update insert etc. was good..
					return true;
				}
			}
		}

		function get_var($query = null, $x = 0, $y = 0)
		{
			// Log how the function was called
			$this->func_call = "\$db->get_var(\"$query\",$x,$y)";

			// If there is a query then perform it if not then use cached results..
			if($query)
				$this->query($query);

			// Extract var out of cached results based x,y vals
			if($this->last_result[$y])
				$values = array_values(get_object_vars($this->last_result[$y]));

			// If there is a value return it else return null
			return(isset($values[$x]) && $values[$x] !== '') ? $values[$x] : null;
		}

		function get_row($query = null, $output = OBJECT, $y = 0)
		{
			// Log how the function was called
			$this->func_call = "\$db->get_row(\"$query\",$output,$y)";

			// If there is a query then perform it if not then use cached results..
			if($query)
				$this->query($query);

			if($output == OBJECT)
				return $this->last_result[$y] ? $this->last_result[$y] : null;
			else if($output == ARRAY_A)
				return $this->last_result[$y] ? get_object_vars($this->last_result[$y]) : null;
			else if($output == ARRAY_N)
				return $this->last_result[$y] ? array_values(get_object_vars($this->last_result[$y])) : null;
			else
				trigger_error(" \$db->get_row(string query, output type, int offset) -- Output type must be one of: OBJECT, ARRAY_A, ARRAY_N", E_USER_ERROR);
		}

		function get_col($query = null, $x = 0)
		{
			// If there is a query then perform it if not then use cached results..
			if($query)
				$this->query($query);

			// Extract the column values
			for($i=0; $i < count($this->last_result); $i++ )
			{
				$new_array[$i] = $this->get_var(null, $x, $i);
			}

			return $new_array;
		}

		function get_results($query = null, $output = OBJECT)
		{
			// Log how the function was called
			$this->func_call = "\$db->get_results(\"$query\", $output)";

			// If there is a query then perform it if not then use cached results..
			if($query)
				$this->query($query);

			// Send back array of objects. Each row is an object
			if($output == OBJECT)
				return $this->last_result;
			else if($output == ARRAY_A || $output == ARRAY_N)
			{
				if($this->last_result)
				{
					$i=0;
					foreach($this->last_result as $row)
					{
						$new_array[$i] = get_object_vars($row);
						if($output == ARRAY_N)
							$new_array[$i] = array_values($new_array[$i]);
						$i++;
					}
					return $new_array;
				}
				else
					return null;
			}
		}

		function get_col_info($info_type = "name", $col_offset = -1)
		{
			if($this->col_info)
			{
				if($col_offset == -1)
				{
					$i = 0;
					foreach($this->col_info as $col)
					{
						$new_array[$i] = $col->{$info_type};
						$i++;
					}
					return $new_array;
				}
				else
					return $this->col_info[$col_offset]->{$info_type};
			}
		}

		function debug()
		{
			echo "<blockquote>";
			echo "<font face=arial size=2 color=000099><b>Query --</b> ";
			echo "[<font color=000000><b>$this->last_query</b></font>]</font><p>";
			echo "<font face=arial size=2 color=000099><b>Query Result..</b></font>";
			echo "<blockquote>";

			if($this->col_info)
			{
				echo "<table cellpadding=5 cellspacing=1 bgcolor=555555>";
				echo "<tr bgcolor=eeeeee><td nowrap valign=bottom><font color=555599 face=arial size=2><b>(row)</b></font></td>";

				for ( $i=0; $i < count($this->col_info); $i++ )
				{
					echo "<td nowrap align=left valign=top><font size=1 color=555599 face=arial>{$this->col_info[$i]->type} {$this->col_info[$i]->max_length}</font><br><font size=2><b>{$this->col_info[$i]->name}</b></font></td>";
				}

				echo "</tr>";

				// ======================================================
				// print main results
				if($this->last_result)
				{
					$i = 0;
					foreach($this->get_results(null,ARRAY_N) as $one_row)
					{
						$i++;
						echo "<tr bgcolor=ffffff><td bgcolor=eeeeee nowrap align=middle><font size=2 color=555599 face=arial>$i</font></td>";

 						foreach ( $one_row as $item )
						{
							echo "<td nowrap><font face=arial size=2>$item</font></td>";
						}
						echo "</tr>";
					}
				} // if last result
				else
					echo "<tr bgcolor=ffffff><td colspan=".(count($this->col_info)+1)."><font face=arial size=2>No Results</font></td></tr>";

				echo "</table>";
			} // if col_info
			else
				echo "<font face=arial size=2>No Results</font>";

			echo "</blockquote></blockquote><hr noshade color=dddddd size=1>";
		}
	}

    $db = &new db($myConfig->DB_USER, $myConfig->DB_PASSWORD, $myConfig->DB_NAME, $myConfig->DB_HOST);

?>