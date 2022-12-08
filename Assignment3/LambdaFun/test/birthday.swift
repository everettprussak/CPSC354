import SwiftUI

struct User: Identifiable{
    let id = UUID()
var name:String
var month:Int
var day:Int
var year:Int
    let id_a:Int
}

class UserContainer: ObservableObject{
    @Published var users = [User]()
}

struct ContentView: View{
    @ObservedObject var usersContainer = UserContainer()

    @State var navi = false

    @State var personalView = false

    @State var i = UUID()

    @State var id_string:String = ""

    var id_num:Int = -1

    @State var num1:Int = 0

    @State var person:User = User(name:"d",month:1,day:1,year:2000,id_a:1)

    var body: some View {
        NavigationView{
            List(usersContainer.users, id: \.id){
                user in
                Button(user.name){
                    num1 = user.id_a
                    person = user
                    //changePerson.toggle()
                    personalView.toggle()
                }
            }
            .sheet(isPresented: $personalView){
                Personal(usersContainer: usersContainer, person_id: num1, person:person, navi:false)
            }
            .sheet(isPresented: $navi){
                AddingView(usersContainer: usersContainer, navi: false)
            }
            .navigationBarTitle(Text("Your Friends" + String(num1)))
    }
        Button("Add Friend"){
            navi.toggle()
        }
        .padding()
    }
}

struct AddingView: View{

    @ObservedObject var usersContainer: UserContainer

    @State var name:String = ""

    @State var month:Int = 0

    @State var day:Int = 0

    @State var year:Int = 0

    @State var num1:Int = 0

    @State var navi:Bool = false

    let month_choices = [1,2,3,4,5,6,7,8,9,10,11,12]
    let day_choices = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]

    let year_choices = [2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022]

    var body: some View{
            VStack{
                Text("Adding Friend")
                TextField("Name",text:$name)
                    .padding(15)
                    .background(Color(.systemGray6))
                    .cornerRadius(75)
                Text("Select Month")
                Picker("Select Month", selection: $month) {
                    ForEach(month_choices, id: \.self) {
                        Text(String($0))
                    }
                }
                .pickerStyle(.menu)
                Text("Select Day")
                Picker("Select Day", selection: $day) {
                    ForEach(day_choices, id: \.self) {
                        Text(String($0))
                    }
                }
                .pickerStyle(.menu)
                Text("Select Year")
                Picker("Select Year", selection: $year) {
                    ForEach(year_choices, id: \.self) {
                        Text(String($0))
                    }
                }
                .pickerStyle(.menu)

                Button("Save"){
                    self.num1 = self.usersContainer.users.count
                    self.usersContainer.users.append(User(name:name, month:month, day:day,year:year, id_a: num1))
                    navi.toggle()
                }
                .sheet(isPresented: $navi){
                    ContentView(usersContainer: usersContainer, navi: false, num1: num1)
                }
        }
    }
}

struct Personal: View{
    @ObservedObject var usersContainer:UserContainer

    @State var person_id:Int = 0

    var person:User

    @State var navi = false

    @State var now = Date.now

    @State var edit = false

    var body: some View {
        NavigationView{
        VStack{
            //Text(String(person_id))
            //Text(usersContainer.users[person_id].name)
            Text("Today")
            Text(Date.now, format: .dateTime.day().month())
            Text("")
            Text("Birthday")
            //Text(String(person_id))
            Text("Month: " + String(usersContainer.users[person_id].month))
             Text("Day: " + String(usersContainer.users[person_id].day))
            Text("Year: " + String(usersContainer.users[person_id].year))

            Button("Edit"){ //Edit Instead?
                edit.toggle()
            }
            .sheet(isPresented: $edit){
                EditView(usersContainer: usersContainer, person_id: person_id, navi:false)
            }
        }
        .navigationTitle(usersContainer.users[person_id].name)
        }
        Button("Back"){
            navi.toggle()
        }
        .padding()
        .sheet(isPresented: $navi){
            ContentView(usersContainer: usersContainer, navi: false, num1: person_id)
        }
    }
}


struct EditView: View {
    @ObservedObject var usersContainer:UserContainer

    @State var person_id = 0

    @State var month:Int = 0

    @State var name:String = ""

    @State var day:Int = 0

    @State var year:Int = 0

    @State var num1:Int = 0

    @State var navi:Bool = false

    let month_choices = [1,2,3,4,5,6,7,8,9,10,11,12]
    let day_choices = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]

    let year_choices = [2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022]

    var body: some View{
        VStack{
            Text("Adding Friend")
            TextField("Name",text:$name)
                .padding(15)
                .background(Color(.systemGray6))
                .cornerRadius(75)
            Text("Select Month")
            Picker("Select Month", selection: $month) {
                ForEach(month_choices, id: \.self) {
                    Text(String($0))
                }
            }
            .pickerStyle(.menu)
            Text("Select Day")
            Picker("Select Day", selection: $day) {
                ForEach(day_choices, id: \.self) {
                    Text(String($0))
                }
            }
            .pickerStyle(.menu)
            Text("Select Year")
            Picker("Select Year", selection: $year) {
                ForEach(year_choices, id: \.self) {
                    Text(String($0))
                }
            }
            .pickerStyle(.menu)

            Button("Save"){
                //self.num1 = self.usersContainer.users.count
                //self.usersContainer.users.append(User(name:name, month:month, day:day,year:year, id_a: num1))
                self.usersContainer.users[person_id].name = name
                self.usersContainer.users[person_id].month = month
                self.usersContainer.users[person_id].day = day
                self.usersContainer.users[person_id].year = year
                navi.toggle()
            }
            .sheet(isPresented: $navi){
                ContentView(usersContainer: usersContainer, navi: false, num1: num1)
            }
            Button("Cancel"){
                navi.toggle()
            }
        }
    }

}
