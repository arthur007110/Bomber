/**
	@description Returns a random instance of getting n from base chance
	@param {real} n chance of getting a true vallue
	@param {real} base how dificcult is to get the n chance, needs to be greater or equal than n
*/
function chance_of(n, base){
	return irandom(base) <= n;
}