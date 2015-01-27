component persistent="true" table="Player" {
    property name="PlayerID" column = "PlayerID" generator="increment";
	property name="FirstName" type="string";
	property name="LastName" type="string";
	property name="CreatedOn" ormtype="timestamp";
	property name="Active" type="boolean";
}