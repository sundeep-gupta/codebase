      use DBI;     use Data::Dumper;

      @driver_names = DBI->available_drivers;
      %drivers      = DBI->installed_drivers;
      @data_sources = DBI->($driver_name);
      print Dumper(%attr);
      print Dumper(@driver_names);