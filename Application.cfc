component {
	THIS.name = Config().name;

	function config() {
		if ( !structKeyExists(THIS, "$Config"))	{
            var THIS[ "$Config" ] = StructNew();

	        if (REFind( "localhost", CGI.server_name )) {
	            THIS["$Config"].name = "Skoreos_LOCAL";
	        } else if (REFind( "dev", CGI.server_name )) {
	            THIS["$Config"].name = "Skoreos_DEV";
	        } else {
	            THIS["$Config"].name = "Skoreos_PRODUCTION";
	        }
		}

		return THIS[ "$Config" ];
	}

}