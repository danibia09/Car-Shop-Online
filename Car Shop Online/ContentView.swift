//
//  ContentView.swift
//  Car Shop Online
//
//  Created by Danilo Maria Bianco on 07/06/25.
//

// fondamentale affinchè si visualizzi l'anteprima
import SwiftUI



// Struttura principale dell'app
struct ContentView: View {
    // crea istanza di CarStore come oggetto di stato
    @StateObject private var carStore = CarStore()
    // Stato per controllare se mostrare lo splash screen (schermata di caricamento)
    @State private var isSplashActive = true
    
    // Vista di navigazione principale
    var body: some View {
        NavigationView {
            ZStack {
                // Mostra lo splash screen se attivo, altrimenti mostra la login view
                if isSplashActive {
                    SplashScreenView(isActive: $isSplashActive)
                } else {
                    LoginView(carStore: carStore)
                }
            }
        }
    }
}

// Vista dello splash screen con animazione
struct SplashScreenView: View {
    // Binding per controllare se lo splash è attivo
    @Binding var isActive: Bool
  
    // Stato per l'offset dell'animazione della macchina (indica una distanza, un valore numerico che si aggiunge a una posizione di partenza per indicare un'altra posizione diversa)
    @State private var carOffset: CGFloat = UIScreen.main.bounds.width + 10
  
    // Stato per il bottone premuto
    @State private var isButtonPressed = false
    
    var body: some View {
        ZStack {
            // Sfondo gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Logo con due macchine
                HStack(spacing: 30) {
                    Image(systemName: "car.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.white)
                    
                    Image(systemName: "car.2.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .foregroundColor(.white)
                }
                .padding(.top, 50)
                
                Text("Car Shop Online")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                
                    .padding(20)
                // Macchina animata
                Image(systemName: "car.side.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.red)
                    .offset(x: carOffset, y: 0)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 7.0).repeatForever(autoreverses: false)) {
                            carOffset = -UIScreen.main.bounds.width - 100
                        }
                    }
                
                Spacer()
                
                // Bottone obbligatorio
                Button(action: {
                    withAnimation {
                        isButtonPressed = true
                        isActive = false
                    }
                }) {
                    Text("ENTRA NEL MERCATO")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250)
                        .background(isButtonPressed ? Color.green : Color.blue)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .shadow(radius: 10)
                }
                .padding(.bottom, 70)
            }
        }
    }
}

// classe che contiene tutte le macchine in vendita con nome , prezzo , immagine / icona , descrizione e contatto che verranno poi visualizzati nella schermata acquirente
class CarStore: ObservableObject {
    @Published var availableCars: [Car] = [
        Car(id: UUID(), name: "Tesla Model 3", price: "€45000", imageName: "bolt.car.fill", isNew: true, details: "Tesla Model 3 – Perfette condizioni, pronta a partire!Vendo Tesla Model 3, anno 2025, nuova . Autonomia fino a 500 km, interni moderni e tecnologia all'avanguardia. Sempre tagliandata . Full optional: Autopilot, sedili riscaldati, cerchi in lega, e molto altro.Perfetta per chi cerca comfort, prestazioni ed efficienza 100% elettrica."  , sellerContact: "tesla@dealer.com  / 324654321", type: .automobile),
        Car(id: UUID(), name: "Fiat Panda", price: "€14,500", imageName: "car.fill", isNew: false, details: "Vendo Fiat Panda usata, in buone condizioni generali, perfetta per la città e i piccoli spostamenti. Motore affidabile, consumi contenuti e manutenzione regolare. Ideale per neopatentati o come seconda auto.Pronta all'uso, prezzo interessante!", sellerContact: "fiat@dealer.com / 345212213", type: .automobile),
        Car(id: UUID(), name: "Porsche Taycan", price: "€120,000", imageName: "car.side.fill", isNew: true, details: "Vendo Porsche Taycan nuova, immatricolata [inserisci anno], mai utilizzata. Eleganza, potenza e tecnologia si incontrano in questa berlina sportiva 100% elettrica. Autonomia elevata, ricarica ultraveloce e prestazioni da vera Porsche. Interni di lusso, dotazione completa e stile inconfondibile.Disponibile da subito, occasione unica per veri intenditori.", sellerContact: "porsche@dealer.com / 333555213", type: .automobile),
        Car(id: UUID(), name: "Ducati Panigale", price: "€25,000", imageName: "motorcycle.fill", isNew: false, details: "Vendo Ducati Panigale usata, in ottime condizioni, tagliandata regolarmente e tenuta sempre in garage. Moto sportiva dal design aggressivo e prestazioni mozzafiato, ideale per chi cerca emozioni forti su strada o pista.Anno 2021, 10000 km, versione V4, accessoriata e pronta a partire.", sellerContact: "ducati@dealer.com / 365256666", type: .moto),
        Car(id: UUID(), name: "Airstream Bambi", price: "€65,000", imageName: "airplane.departure", isNew: true, details: "Vendo aereo privato nuovo, battezzato Airstream Bambi : un nome che unisce stile, leggerezza e spirito libero. Prestazioni eccellenti, avionica moderna e design raffinato, ideale per voli privati comodi e sicuri.Perfetto per chi cerca un velivolo distintivo, con ore di volo pari a zero e pronto al decollo. Un'occasione rara per chi ama volare con carattere.", sellerContact: "airstream@dealer.com / 390834557", type: .camper)
    ]
    
    // le @published var ci consentono di creare oggetti osservabili che annunciano automaticamente quando si verificano cambiamenti.
    @Published var userCars: [Car] = []
    @Published var users: [User] = []
    @Published var cartItems: [Car] = []
    @Published var currentUser: String? = nil
    
    func addCar(_ car: Car) {
        userCars.append(car)
    }
    
    func deleteCar(at index: IndexSet) {
        userCars.remove(atOffsets: index)
    }
    
    func purchaseCar(_ car: Car) {
        availableCars.removeAll { $0.id == car.id }
    }
    
    func registerUser(username: String, password: String) {
        users.append(User(username: username, password: password))
    }
    
    func validateUser(username: String, password: String) -> Bool {
        let isValid = users.contains { $0.username == username && $0.password == password }
        if isValid {
            currentUser = username
        }
        return isValid
    }
    
    func logout() {
        currentUser = nil
    }
    
    // Queste funzioni permettono di aggiungere al carrello gli elementi , li rimuove , rimuove gli oggetti dal carrello e calcola i soldi che hai speso comprando i veicoli
    func addToCart(_ car: Car) {
        if !cartItems.contains(where: { $0.id == car.id }) {
            cartItems.append(car)
        }
    }
    
    func removeFromCart(_ car: Car) {
        cartItems.removeAll { $0.id == car.id }
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
    
    func totalCartPrice() -> String {
        let total = cartItems.reduce(0) { result, car in
            let priceString = car.price.replacingOccurrences(of: "€", with: "").replacingOccurrences(of: ",", with: "")
            let price = Double(priceString) ?? 0
            return result + price
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "€"
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "it_IT")
        
        return formatter.string(from: NSNumber(value: total)) ?? "€0,00"
    }
}

struct Car: Identifiable {
    let id: UUID
    let name: String
    let price: String
    let imageName: String
    let isNew: Bool
    var details: String?
    var sellerContact: String?
    let type: VehicleType
    
    // L'enumerazione in questo caso contiene i vari casi di veicoli sotto forma di testo
    enum VehicleType: String, CaseIterable {
        case automobile = "Auto"
        case moto = "Moto"
        case camper = "Aereo"
        case furgone = "Furgone"
    }
}

struct User {
    let username: String
    let password: String
}

// Loging View : Usiamo una struct di tipo View che mostra i vari campi e mostra i vari errori
struct LoginView: View {
    @ObservedObject var carStore: CarStore
    @State private var username = ""
    @State private var password = ""
    @State private var isDealer = false
    @State private var isLoggedIn = false
    @State private var showingRegister = false
    @State private var loginError = false
    
    // Icone di acquirente e venditore
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: isDealer ? "building.2.fill" : "person.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
            
            // Picker con le due modalità : Acquirente e venditore
            Picker("Modalità", selection: $isDealer) {
                Text("Acquirente").tag(false)
                Text("Venditore").tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            // Bottone Accedi , se username e password sono corretti allora permette il Login altrimenti indica errore
            Button("Accedi") {
                if carStore.validateUser(username: username, password: password) {
                    isLoggedIn = true
                } else {
                    loginError = true
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .alert("Credenziali errate", isPresented: $loginError) {
                Button("OK", role: .cancel) { }
            }
            
            // Mostra il pulsante di registrazione solo se non c'è un utente loggato
            if carStore.currentUser == nil {
                Button("Non sei registrato? Registrati ora") {
                    showingRegister = true
                }
                .sheet(isPresented: $showingRegister) {
                    RegisterView(carStore: carStore)
                }
            }
            
            // Aggiunto pulsante di logout se l'utente è loggato
            if carStore.currentUser != nil {
                Button("Logout") {
                    carStore.logout()
                    username = ""
                    password = ""
                }
                .buttonStyle(.bordered)
                .tint(.red)
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .background(
            NavigationLink(
                destination: isDealer ? AnyView(SellHomeView(carStore: carStore)) : AnyView(BuyHomeView(carStore: carStore)),
                isActive: $isLoggedIn,
                label: { EmptyView() }
            )
        )
    }
}

// Se non sei registrato allora premi il bottone di prima e porta a una nuova schermata che mostra i campi , username , password , confirmPassword e mostra l'errore nel caso le due password non coincidono
struct RegisterView: View {
    @ObservedObject var carStore: CarStore
    @Environment(\.dismiss) var dismiss
    
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var registrationError = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Crea il tuo account")) {
                    TextField("Username", text: $username)
                    SecureField("Password", text: $password)
                    SecureField("Ripeti Password", text: $confirmPassword)
                }
                
                if !registrationError.isEmpty {
                    Text(registrationError)
                        .foregroundColor(.red)
                }
                
                Button("Registrati") {
                    if password != confirmPassword {
                        registrationError = "Le password non coincidono"
                        showingError = true
                    } else {
                        carStore.registerUser(username: username, password: password)
                        dismiss()
                    }
                }
                .disabled(username.isEmpty || password.isEmpty || confirmPassword.isEmpty)
            }
            .navigationTitle("Registrazione")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annulla") { dismiss() }
                }
            }
            .alert("Errore", isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(registrationError)
            }
        }
    }
}

// Buy Home View con Carrello
struct BuyHomeView: View {
    @ObservedObject var carStore: CarStore
    @State private var searchText = ""
    @State private var selectedType: Car.VehicleType? = nil
    @State private var showingCart = false
    
    var filteredCars: [Car] {
        var result = carStore.availableCars
        
        if !searchText.isEmpty {
            result = result.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        if let selectedType = selectedType {
            result = result.filter { $0.type == selectedType }
        }
        
        return result
    }
    
    var body: some View {
        VStack {
            // Filtri per tipo veicolo
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button(action: { selectedType = nil }) {
                        Text("Tutti")
                            .padding(10)
                            .background(selectedType == nil ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedType == nil ? .white : .primary)
                            .cornerRadius(10)
                    }
                    
                    ForEach(Car.VehicleType.allCases, id: \.self) { type in
                        Button(action: { selectedType = type }) {
                            Text(type.rawValue)
                                .padding(10)
                                .background(selectedType == type ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(selectedType == type ? .white : .primary)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            List(filteredCars) { car in
                NavigationLink(destination: CarDetailView(car: car, carStore: carStore)) {
                    HStack {
                        Image(systemName: car.imageName)
                            .resizable()
                            .frame(width: 40, height: 30)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text(car.name)
                                .font(.headline)
                            
                            HStack {
                                Text(car.price)
                                    .foregroundColor(.secondary)
                                
                                if car.isNew {
                                    Text("NUOVO")
                                        .font(.caption2)
                                        .padding(3)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(3)
                                }
                                
                                Spacer()
                                
                                Text(car.type.rawValue)
                                    .font(.caption)
                                    .padding(5)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Veicoli Disponibili")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingCart = true }) {
                        Image(systemName: "cart.fill")
                            .overlay(
                                Text("\(carStore.cartItems.count)")
                                    .font(.caption2)
                                    .padding(5)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .offset(x: 10, y: -10)
                                    .opacity(carStore.cartItems.isEmpty ? 0 : 1)
                            )
                    }
                }
            }
            .sheet(isPresented: $showingCart) {
                CartView(carStore: carStore)
            }
        }
    }
}

// Cart View : struttura del carrello che mette icona del carrello e indica il testo il tuo carrello è vuoto se non hai aggiunto niente al carrello
struct CartView: View {
    @ObservedObject var carStore: CarStore
    @Environment(\.dismiss) var dismiss
    @State private var showingCheckout = false
    
    var body: some View {
        NavigationView {
            VStack {
                if carStore.cartItems.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "cart.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("Il tuo carrello è vuoto")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List {
                        ForEach(carStore.cartItems) { car in
                            HStack {
                                Image(systemName: car.imageName)
                                    .resizable()
                                    .frame(width: 40, height: 30)
                                    .foregroundColor(.blue)
                                
                                VStack(alignment: .leading) {
                                    Text(car.name)
                                        .font(.headline)
                                    Text(car.price)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    carStore.removeFromCart(car)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                        HStack {
                            Text("Totale")
                                .font(.headline)
                            Spacer()
                            Text(carStore.totalCartPrice())
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Button("Procedi all'acquisto") {
                        showingCheckout = true
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .sheet(isPresented: $showingCheckout) {
                        CheckoutView(carStore: carStore)
                    }
                }
            }
            .navigationTitle("Carrello")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Chiudi") { dismiss() }
                }
            }
        }
    }
}

// Sell Home View con esempi di annunci e i tuoi annunci
struct SellHomeView: View {
    @ObservedObject var carStore: CarStore
    @State private var showingAddCar = false
    
    var body: some View {
        List {
            Section(header: Text("Esempi di annunci")) {
                ForEach(carStore.availableCars.prefix(3)) { car in
                    VStack(alignment: .leading) {
                        Text(car.name)
                            .font(.headline)
                        Text(car.price)
                            .foregroundColor(.secondary)
                        Text(car.details ?? "")
                            .font(.caption)
                            .lineLimit(2)
                    }
                }
            }
            
            Section(header: Text("I tuoi annunci")) {
                ForEach(carStore.userCars) { car in
                    VStack(alignment: .leading) {
                        Text(car.name)
                            .font(.headline)
                        Text(car.price)
                    }
                }
                .onDelete(perform: carStore.deleteCar)
            }
        }
        .navigationTitle("Vendi Veicolo")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { showingAddCar = true }) {
                    Label("Aggiungi", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddCar) {
            AddCarView(carStore: carStore)
        }
    }
}

// Add Car View (schermata presente in venditore) con i campi nome , prezzo , dettagli , contatto , se è nuovo o no , icona e tipo di veicolo
struct AddCarView: View {
    @ObservedObject var carStore: CarStore
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var price = ""
    @State private var details = ""
    @State private var contact = ""
    @State private var isNew = true
    @State private var selectedImage = "car.fill"
    @State private var selectedType: Car.VehicleType = .automobile
    
    let vehicleIcons = [
        ("Auto", "car.fill"),
        ("Moto", "bicycle"),
        ("Aereo", "airplane.departure"),
        ("Furgone", "box.truck")
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informazioni Veicolo")) {
                    TextField("Modello", text: $name)
                    TextField("Prezzo", text: $price)
                    Toggle("Nuovo", isOn: $isNew)
                    
                    Picker("Tipo", selection: $selectedType) {
                        ForEach(Car.VehicleType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    
                    Picker("Icona", selection: $selectedImage) {
                        ForEach(vehicleIcons, id: \.1) { name, icon in
                            Label(name, systemImage: icon).tag(icon)
                        }
                    }
                }
                
                Section(header: Text("Dettagli")) {
                    TextEditor(text: $details)
                        .frame(minHeight: 100)
                }
                
                Section(header: Text("Contatti")) {
                    TextField("Telefono/Email", text: $contact)
                }
                
                // Bottone che ti permette di pubblicare l'annuncio solo se hai completato tutti i campi
                Button("Pubblica Annuncio") {
                    let newCar = Car(
                        id: UUID(),
                        name: name,
                        price: price,
                        imageName: selectedImage,
                        isNew: isNew,
                        details: details.isEmpty ? nil : details,
                        sellerContact: contact.isEmpty ? nil : contact,
                        type: selectedType
                    )
                    carStore.addCar(newCar)
                    dismiss()
                }
                .disabled(name.isEmpty || price.isEmpty)
            }
            .navigationTitle("Nuovo Veicolo")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annulla") { dismiss() }
                }
            }
        }
    }
}

// Car Detail View con aggiunta al carrello
struct CarDetailView: View {
    let car: Car
    @ObservedObject var carStore: CarStore
    @State private var showingContact = false
    @State private var showingCheckout = false
    @State private var isInCart = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    Color.gray.opacity(0.3)
                        .frame(height: 200)
                        .cornerRadius(10)
                    
                    Image(systemName: car.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .foregroundColor(.blue)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(car.name)
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        Text(car.price)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.blue)
                    }
                    
                    HStack {
                        if car.isNew {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("Nuovo")
                            }
                            .foregroundColor(.green)
                        }
                        
                        Spacer()
                        
                        Text(car.type.rawValue)
                            .padding(5)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(5)
                    }
                }
                
                if let details = car.details {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Descrizione")
                            .font(.headline)
                        Text(details)
                    }
                }
                
                VStack(spacing: 10) {
                    Button(action: { showingContact = true }) {
                        Label("Contatta Venditore", systemImage: "phone")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .sheet(isPresented: $showingContact) {
                        ContactView(contact: car.sellerContact ?? "Nessun contatto fornito")
                    }
                    
                    if carStore.cartItems.contains(where: { $0.id == car.id }) {
                        Button(action: {
                            carStore.removeFromCart(car)
                        }) {
                            Label("Rimuovi dal Carrello", systemImage: "cart.badge.minus")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .tint(.red)
                    } else {
                        Button(action: {
                            carStore.addToCart(car)
                        }) {
                            Label("Aggiungi al Carrello", systemImage: "cart.badge.plus")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    Button(action: { showingCheckout = true }) {
                        Label("Acquista Ora", systemImage: "creditcard")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $showingCheckout) {
                        SingleCheckoutView(car: car, carStore: carStore)
                    }
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Dettagli")
        .onAppear {
            isInCart = carStore.cartItems.contains { $0.id == car.id }
        }
    }
}

// Checkout View per singolo prodotto
struct SingleCheckoutView: View {
    let car: Car
    @ObservedObject var carStore: CarStore
    @Environment(\.dismiss) var dismiss
    
    @State private var paymentMethod = "Carta di Credito"
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    @State private var isProcessing = false
    @State private var showSuccess = false
    @State private var showReview = false
    
    let paymentMethods = ["Carta di Credito", "PayPal", "Bonifico"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Riepilogo")) {
                    HStack {
                        Text(car.name)
                        Spacer()
                        Text(car.price)
                    }
                    
                    HStack {
                        Text("Tipo")
                        Spacer()
                        Text(car.type.rawValue)
                    }
                }
                
                Section(header: Text("Pagamento")) {
                    Picker("Metodo", selection: $paymentMethod) {
                        ForEach(paymentMethods, id: \.self) { method in
                            Text(method)
                        }
                    }
                    
                    if paymentMethod == "Carta di Credito" {
                        TextField("Numero Carta", text: $cardNumber)
                            .keyboardType(.numberPad)
                        TextField("Scadenza (MM/AA)", text: $expiryDate)
                        TextField("CVV", text: $cvv)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section {
                    Button(action: processPayment) {
                        HStack {
                            if isProcessing {
                                ProgressView()
                            } else {
                                Text("Conferma Acquisto")
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .disabled(isProcessing || (paymentMethod == "Carta di Credito" && (cardNumber.isEmpty || expiryDate.isEmpty || cvv.isEmpty)))
                }
            }
            .navigationTitle("Checkout")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annulla") { dismiss() }
                }
            }
            .alert("Acquisto Completato!", isPresented: $showSuccess) {
                Button("OK", role: .cancel) {
                    carStore.purchaseCar(car)
                    carStore.removeFromCart(car)
                    showReview = true
                }
            } message: {
                Text("Hai acquistato \(car.name) per \(car.price)")
            }
            .sheet(isPresented: $showReview) {
                ReviewView(isPresented: $showReview)
            }
        }
    }
    
    private func processPayment() {
        isProcessing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isProcessing = false
            showSuccess = true
        }
    }
}

// Checkout View per il carrello
struct CheckoutView: View {
    @ObservedObject var carStore: CarStore
    @Environment(\.dismiss) var dismiss
    
    @State private var paymentMethod = "Carta di Credito"
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    @State private var isProcessing = false
    @State private var showSuccess = false
    @State private var showReview = false
    
    let paymentMethods = ["Carta di Credito", "PayPal", "Bonifico"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Riepilogo")) {
                    ForEach(carStore.cartItems) { car in
                        HStack {
                            Text(car.name)
                            Spacer()
                            Text(car.price)
                        }
                    }
                    
                    HStack {
                        Text("Totale")
                            .font(.headline)
                        Spacer()
                        Text(carStore.totalCartPrice())
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
                
                Section(header: Text("Pagamento")) {
                    Picker("Metodo", selection: $paymentMethod) {
                        ForEach(paymentMethods, id: \.self) { method in
                            Text(method)
                        }
                    }
                    
                    if paymentMethod == "Carta di Credito" {
                        TextField("Numero Carta", text: $cardNumber)
                            .keyboardType(.numberPad)
                        TextField("Scadenza (MM/AA)", text: $expiryDate)
                        TextField("CVV", text: $cvv)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section {
                    Button(action: processPayment) {
                        HStack {
                            if isProcessing {
                                ProgressView()
                            } else {
                                Text("Conferma Acquisto")
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .disabled(isProcessing || carStore.cartItems.isEmpty || (paymentMethod == "Carta di Credito" && (cardNumber.isEmpty || expiryDate.isEmpty || cvv.isEmpty)))
                }
            }
            .navigationTitle("Checkout")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annulla") { dismiss() }
                }
            }
            .alert("Acquisto Completato!", isPresented: $showSuccess) {
                Button("OK", role: .cancel) {
                    // Rimuovi tutte le auto acquistate dal carrello e dalla lista disponibile
                    for car in carStore.cartItems {
                        carStore.purchaseCar(car)
                    }
                    carStore.clearCart()
                    showReview = true
                }
            } message: {
                Text("Hai acquistato \(carStore.cartItems.count) veicoli per un totale di \(carStore.totalCartPrice())")
            }
            .sheet(isPresented: $showReview) {
                ReviewView(isPresented: $showReview)
            }
        }
    }
    
    private func processPayment() {
        isProcessing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isProcessing = false
            showSuccess = true
        }
    }
}

// Schermata di recensione
struct ReviewView: View {
    @Binding var isPresented: Bool
    @State private var reviewText = ""
    @State private var rating = 5
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Lascia una recensione")) {
                    TextEditor(text: $reviewText)
                        .frame(minHeight: 100)
                    
                    HStack {
                        Text("Valutazione:")
                        Spacer()
                        Picker("", selection: $rating) {
                            ForEach(1..<6) { number in
                                Text("\(number)").tag(number)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 150)
                    }
                }
                
                Button("Invia Recensione") {
                    isPresented = true
                }
                .disabled(reviewText.isEmpty)
            }
            .navigationTitle("Recensione")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annulla") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

// Contact View
struct ContactView: View {
    let contact: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                
                Text("Contatta il venditore")
                    .font(.title2)
                    .bold()
                
                Text(contact)
                    .textSelection(.enabled)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Button("Copia Contatto") {
                    UIPasteboard.general.string = contact
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Contatti")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Chiudi") { dismiss() }
                }
            }
        }
    }
}

// Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
