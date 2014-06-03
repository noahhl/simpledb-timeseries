This is a simple port of antirez/redis-timeseries to use Amazon AWS
SimpleDB is the actual storage engine.

##Considerations
When updating an existing key, the new encoded value is just added to the array
of values. AWS imposes a limit on that array of 256 elements. Practically, this
means that <code>timestep/flush_interval</code> should be selected such that no
more than 256 measurements are included in a single key -- in other words, if
data is written every 10 seconds, the maximum timestep used should be 2560
seconds (about 42 minutes of data will be contained within each key).

##Usage

<pre>
$ irb
>> require 'simpledb-timeseries'
=> true
>> sdb = AwsSdb::Service.new
=> #<AwsSdb::Service:0x104f72498 @logger=#<Logger:0x104f71ed0 @default_formatter=#<Logger::Formatter:0x104f71de0 @datetime_format=nil>, @progname=nil, @logdev=#<Logger::LogDevice:0x104f71d90 @shift_age=0, @filename="aws_sdb.log", @mutex=#<Logger::LogDevice::LogDeviceMutex:0x104f71d40 @mon_waiting_queue=[], @mon_entering_queue=[], @mon_count=0, @mon_owner=nil>, @dev=#<File:aws_sdb.log>, @shift_size=1048576>, @level=0, @formatter=nil>, @secret_access_key="SECRET", @base_url="http://sdb.amazonaws.com", @access_key_id="SECRET">
>> ts = SimpleDBTimeSeries.new("mytimeseries", 60, sdb)
=> #<SimpleDBTimeSeries:0x104f10950 @timestep=60, @domain="timeseries", @prefix="mytimeseries", @sdb=#<AwsSdb::Service:0x104f72498 @logger=#<Logger:0x104f71ed0 @default_formatter=#<Logger::Formatter:0x104f71de0 @datetime_format=nil>, @progname=nil, @logdev=#<Logger::LogDevice:0x104f71d90 @shift_age=0, @filename="aws_sdb.log", @mutex=#<Logger::LogDevice::LogDeviceMutex:0x104f71d40 @mon_waiting_queue=[], @mon_entering_queue=[], @mon_count=0, @mon_owner=nil>, @dev=#<File:aws_sdb.log>, @shift_size=1048576>, @level=0, @formatter=nil>, @secret_access_key="SECRET", @base_url="http://sdb.amazonaws.com", @access_key_id="SECRET">>
>> ts.add("10")
=> nil
>> ts.add("20")
=> nil
>> ts.add("30")
=> nil
>> ts.add("50")
=> nil
>> ts.fetch_range(Time.now.to_i-120, Time.now.to_i)
=> [{:data=>"10", :time=>1317690578.02122, :origin_time=>nil}, {:data=>"20", :time=>1317690580.09161, :origin_time=>nil}, {:data=>"30", :time=>1317690581.9587, :origin_time=>nil}, {:data=>"50", :time=>1317690584.02876, :origin_time=>nil}]
>> 
</pre>
