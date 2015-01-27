component extends="taffy.core.api" {
    // THIS.name = "Skoroes_REST_DEV";

	THIS.name = Config().name;
	THIS.datasource = Config().dsn;

	THIS.ormenabled = "true";
	THIS.ormsettings.cfclocation = "model/beans";

    variables.framework = {
	    reloadKey = "reload",
	    reloadPassword = "true",
	    reloadOnEveryRequest = true,
		allowCrossDomain = true
	};

	function onApplicationStart() {
	    APPLICATION.beanFactory = new di1.ioc("/skoreosroot/api/model");

	    //set bean factory into Taffy
	    VARIABLES.framework.beanFactory = APPLICATION.beanfactory;

	    super.onApplicationStart();
	}

    function onTaffyRequest(verb, cfc, requestArguments, mimeExt, headers){
		ORMReload();
	
		return true;
	}

	function config() {
		if ( !structKeyExists(THIS, "$Config"))	{
            var THIS[ "$Config" ] = StructNew();

	        if (REFind( "localhost", CGI.server_name )) {
	            THIS["$Config"].name = "SkoreosREST_LOCAL";
	            THIS["$Config"].dsn = "skoreos_ds";
	        } else if (REFind( "dev", CGI.server_name )) {
	            THIS["$Config"].name = "SkoreosREST_DEV";
	            THIS["$Config"].dsn = "skoreos_dev_ds";
	        } else {
	            THIS["$Config"].name = "SkoreosREST_PRODUCTION";
	            THIS["$Config"].dsn = "skoreos_ds";	        	
	        }
		}

		return THIS[ "$Config" ];
	}
}