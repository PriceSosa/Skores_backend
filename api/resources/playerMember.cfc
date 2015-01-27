component extends="taffy.core.resource" taffy_uri="/players/{playerID}" {

    public function get(required numeric playerID) {
        var local = {};

        if (ARGUMENTS.playerID < 1) {
            return representationOf({'status':'error'});
        }

        local.qGetPlayer = VARIABLES.playerSvc.getPlayer(playerID = ARGUMENTS.playerID);
        return representationOf( local.qGetPlayer );
    }

    public function post(required string firstName, required string lastName) {
        var local = {};

        local.qGetPlayer = VARIABLES.playerSvc.createPlayer(firstName = ARGUMENTS.firstName, lastName = ARGUMENTS.lastName);
        return representationOf( local.qGetPlayer );
    }

    public function put(required numeric playerID, required string firstName, required string lastName) {
        var local = {};

        local.qGetPlayer = VARIABLES.playerSvc.updatePlayer(playerID = ARGUMENTS.playerID, firstName = ARGUMENTS.firstName, lastName = ARGUMENTS.lastName);
        return representationOf( local.qGetPlayer );
    }

    public void function setPlayerService(any playerObj) {
        VARIABLES.playerSvc = ARGUMENTS.playerObj;
        return;
    };

}