// Carica i file .stl della geometria
SetFactory("OpenCASCADE");

Merge "bodyCassoneChiuso_mm.stl";
Merge "RR_mm.stl";
Merge "FR_mm.stl";

//v() = ShapeFromFile("bodyCassoneChiuso_mm.stl");
//v() = ShapeFromFile("RR_mm.stl");
//v() = ShapeFromFile("FR_mm.stl");

CreateTopology;

//Aggiungo il volume geometrico di carrozzeria e ruote,
//definendo sia il surface loop che il volume
Surface Loop(1) = {1};
Volume(1) = {1};
Surface Loop(2) = {2};
Volume(2) = {2};
Surface Loop(3) = {3};
Volume(3) = {3};

// Definisci il livello di dettaglio della mesh
cl = 1;

// Definisco i punti minimo e massimo della box
xmin = -100;
xmax = 20;
ymin = -10;
ymax = 0;
zmin = -0.860503;
zmax = 20;

//Box(4) = {xmin, ymin, zmin, xmax-xmin, ymax-ymin, zmax-zmin};

//Definisco i punti della box
Point(0) = {xmin, ymin, zmin, cl};
Point(1) = {xmax, ymin, zmin, cl};
Point(2) = {xmax, ymax, zmin, cl};
Point(3) = {xmin, ymax, zmin, cl};
Point(4) = {xmin, ymin, zmax, cl};
Point(5) = {xmax, ymin, zmax, cl};
Point(6) = {xmax, ymax, zmax, cl};
Point(7) = {xmin, ymax, zmax, cl};

// Definisco le linee della box
Line(0) = {0, 1};
Line(1) = {3, 2};
Line(2) = {7, 6};
Line(3) = {4, 5};
Line(4) = {0, 3};
Line(5) = {1, 2};
Line(6) = {5, 6};
Line(7) = {4, 7};
Line(8) = {0, 4};
Line(9) = {1, 5};
Line(10) = {2, 6};
Line(11) = {3, 7};

// Definisco le superfici della box
// NOTE: i numeri nelle parentesi graffe sono linee, non punti e sono definiti
// come vedi sugli appunti di OpenFOAM, quindi devi anche usare i meno, per le
// linee, se i verso non è concorde a quello del disegno.
// Posso definire le linee sia in senso orario, che antiorario, mentre su 
// OpenFOAM sono costretto ad andare in senso orario, ma comunque quì devo
// ricordarmi cìdi essere coerente con i versi delle linee definite coi punti
// NOTE: se ti stai chiedendo perchè ho usato 10, 20 e csì via, è perchè i
// Line Loop assegnati ai numeri 1, 2 e 3 sono assegnati di default alle
// superfici che ho importato col Merge, quindi alla carrozzeria e alle ruote

// tarmac
Line Loop(00) = {5, -1, -4, 0};
Plane Surface(00) = {00};

// upperArea
Line Loop(10) = {3, 6, -2, -7};
Plane Surface(10) = {10};

// inlet
Line Loop(20) = {5, 10, -6, -9};
Plane Surface(20) = {20};

// outlet
Line Loop(30) = {8, 7, -11, -4};
Plane Surface(30) = {30};

// lateralArea
Line Loop(40) = {0, 9, -3, -8};
Plane Surface(40) = {40};

// symmetryPlane
Line Loop(50) = {11, 2, -10, -1};
Plane Surface(50) = {50};

// Definisco finalmente il volume della box, ma
// prima devo definire un surface loop che identifica
// la box
Surface Loop(4) = {00, 10, 20, 30, 40, 50};
Volume(4) = {4};

// Sottraggo i volumi del truck e gomme al volume della box
//SetFactory("OpenCASCADE");
//BooleanDifference{ Volume{4}; Delete; }{ Volume{1,2,3}; Delete; };
BooleanIntersection{ Volume{4}; }{ Volume{1}; Delete; };
