/*
 * initPlayerServer.sqf
 * Executes only on server when player joins mission
 *
 * Parameters: _player, _didJIP
 *
 */
params ["_playerUnit", "_didJIP"];


// logging player owner ID to server RPT
diag_log formatText ["%1Nouvelle connexion : %3%2ID : %4%2JIP : %5", toString [124,9], toString [9,124,9], name _playerUnit, owner _playerUnit, _didJIP];