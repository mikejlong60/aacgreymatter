package aacgreymatter

import (
	gsl "greymatter.io/gsl/v1"

	"aacgreymatter.module/greymatter:globals"
)


Aac_Service: gsl.#Service & {
	// A context provides global information from globals.cue
	// to your service definitions.
	context: Aac_Service.#NewContext & globals

	// name must follow the pattern namespace/name
	name:          "aac-service"
	display_name:  "Aacgreymatter Aac Service"
	version:       "v1.0.0"
	description:   "EDIT ME"
	api_endpoint:              "http://\(context.globals.edge_host)/services/\(context.globals.namespace)/\(name)/"
	api_spec_endpoint:         "http://\(context.globals.edge_host)/services/\(context.globals.namespace)/\(name)/"
	
	business_impact:           "low"
	owner: "Aacgreymatter"
	capability: ""
	
	// Aac-Service -> ingress to your container
	ingress: {
		(name): {
			gsl.#HTTPListener
			
			
			
			routes: {
				"/": {
					
					upstreams: {
						"local": {
							gsl.#Upstream
							
							instances: [
								{
									host: "127.0.0.1"
									port: 3000
								},
							]
						}
					}
				}
			}
		}
	}


	
	// Edge config for the Aac-Service service.
	// These configs are REQUIRED for your service to be accessible
	// outside your cluster/mesh.
	edge: {
		edge_name: "edge"
		routes: "/services/\(context.globals.namespace)/\(name)": upstreams: (name): {
			gsl.#Upstream
			namespace: context.globals.namespace
			
		}
	}
	
}

exports: "aac-service": Aac_Service
