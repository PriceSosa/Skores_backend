component extends="taffy.core.resource" taffy_uri="/players" {
    
    public function get() {
        var local = {};

        local.qPlayers = VARIABLES.playerSvc.getPlayer(playerID = 0);
        return representationOf( local.qPlayers );
    }

    public void function setPlayerService(any playerObj) {
        VARIABLES.playerSvc = ARGUMENTS.playerObj;
        return;
    };
}