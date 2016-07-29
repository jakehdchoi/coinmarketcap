import std.net.curl, std.stdio,std.csv,std.json;
import std.array : appender;
import std.format : formattedWrite;
import std.file : write;
import std.datetime;
//Limits
//Please limit requests to no more than 10 per minute.

enum URL1 = "https://api.coinmarketcap.com/v1/ticker/";
enum URL2 = "https://api.coinmarketcap.com/v1/ticker/bitcoin/";
enum URL3 = "https://api.coinmarketcap.com/v1/global/";

int main(string argv[]) {

	auto content = get(URL1);
	//writeln(content);

	JSONValue j = parseJSON(content);
	auto writer = appender!string();
	auto items = [	"id", 
					"name", 
					"symbol", 
					"rank", 
					"price_usd", 
					"24h_volume_usd", 
					"market_cap_usd", 
					"available_supply", 
					"total_supply",
					"percent_change_1h", 
					"percent_change_24h", 
					"percent_change_7d"
				];

	foreach(string item; items){
		formattedWrite(writer, "%s,", item);
	}
	writeln("");

	foreach(JSONValue r; j.array){
		//writeln(r);
		formattedWrite(writer,"\n%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s",
					r["id"], 
					r["name"],
					r["symbol"],
					r["rank"],
					r["price_usd"],
					r["24h_volume_usd"],
					r["market_cap_usd"],
					r["available_supply"],
					r["total_supply"],
					r["percent_change_1h"],
					r["percent_change_24h"],
					r["percent_change_7d"]);
	}
	auto currentTime = Clock.currTime();
	auto timeString = currentTime.toISOString();

	write(timeString ~ ".csv", writer.data);
	return 0;
}
