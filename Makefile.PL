use inc::Module::Package 'RDF:tobyink 0.009';

dynamic_config;
requires('UNIVERSAL::DOES', 0) if $] < 5.010;
