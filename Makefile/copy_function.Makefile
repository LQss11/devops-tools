test: 
	$(file >  alertmanager/.env,$(file < .global.env))