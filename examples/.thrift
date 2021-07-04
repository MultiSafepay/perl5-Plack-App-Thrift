namespace perl Thrift

struct Greeting {
    1: required string name;
}

struct Reply {
    1: required string sentence;
}

service GreetingService {
    Reply greet(1:required Greeting greeting)
}
