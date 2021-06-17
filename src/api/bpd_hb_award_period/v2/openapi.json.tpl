{
    "openapi": "3.0.1",
    "info": {
        "title": "BPD HB Award Period API",
        "description": "Api and Models",
        "version": "v2"
    },
    "servers": [{
        "url": "https://${host}/bpd/hb/award-periods/v2"
    }],
    "paths": {
        "/": {
            "get": {
                "summary": "findAll",
                "description": "findAll",
                "operationId": "5f983d5d70d400b2e059b34a",
                "parameters": [{
                    "name": "x-request-id",
                    "in": "header",
                    "description": "x-request-id",
                    "required": true,
                    "schema": {
                        "type": "string"
                    }
                }],
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/AwardPeriodResourceArray"
                                },
                                "example": [{
                                    "awardPeriodId": 0,
                                    "endDate": "string",
                                    "startDate": "string"
                                }]
                            }
                        }
                    },
                    "401": {
                        "description": "Unauthorized"
                    },
                    "500": {
                        "description": ""
                    }
                }
            }
        }
    },
    "components": {
        "schemas": {
            "AwardPeriodResourceArray": {
                "type": "array",
                "items": {
                    "$ref": "#/components/schemas/AwardPeriodResource"
                },
                "example": [{
                    "awardPeriodId": 0,
                    "endDate": "string",
                    "startDate": "string"
                }]
            },
            "AwardPeriodResource": {
                "title": "AwardPeriodResource",
                "required": ["awardPeriodId", "cashbackPercentage", "endDate", "gracePeriod", "maxAmount", "maxPeriodCashback", "maxTransactionCashback", "maxTransactionEvaluated", "minPosition", "minTransactionNumber", "startDate", "status"],
                "type": "object",
                "properties": {
                    "awardPeriodId": {
                        "type": "integer",
                        "description": "Identificativo univoco del periodo di premiazione",
                        "format": "int64"
                    },
                    "cashbackPercentage": {
                        "type": "integer",
                        "description": "Percentuale applicata al cashback",
                        "format": "int64"
                    },
                    "endDate": {
                        "type": "string",
                        "description": "Data di fine periodo premiazione. FORMATO ISO8601 yyyy-MM-dd",
                        "format": "date"
                    },
                    "gracePeriod": {
                        "type": "integer",
                        "description": "Periodo di tolleranza",
                        "format": "int64"
                    },
                    "maxAmount": {
                        "type": "integer",
                        "description": "Importo massimo erogabile nel periodo",
                        "format": "int64"
                    },
                    "maxPeriodCashback": {
                        "type": "integer",
                        "description": "Cashback massimo accumulabile per l'intero periodo",
                        "format": "int64"
                    },
                    "maxTransactionCashback": {
                        "type": "integer",
                        "description": "Cashback massimo accumulabile per singola transazione",
                        "format": "int64"
                    },
                    "maxTransactionEvaluated": {
                        "type": "integer",
                        "description": "Valore massimo trattato sulla transazione",
                        "format": "int64"
                    },
                    "minPosition": {
                        "type": "integer",
                        "description": "Posizione minima per rientrare nel rimborso speciale",
                        "format": "int64"
                    },
                    "minTransactionNumber": {
                        "type": "integer",
                        "description": "Numero minimo di transazioni per accedere al cashback",
                        "format": "int64"
                    },
                    "startDate": {
                        "type": "string",
                        "description": "Data di inizio periodo premiazione. FORMATO ISO8601 yyyy-MM-dd",
                        "format": "date"
                    },
                    "status": {
                        "type": "string",
                        "description": "Stato del periodo (ACTIVE - WAITING - INACTIVE- CLOSED)"
                    }
                },
                "example": {
                    "awardPeriodId": "0.0",
                    "cashbackPercentage": "0.0",
                    "endDate": "string",
                    "gracePeriod": "0.0",
                    "maxAmount": "0.0",
                    "maxPeriodCashback": "0.0",
                    "maxTransactionCashback": "0.0",
                    "maxTransactionEvaluated": "0.0",
                    "minPosition": "0.0",
                    "minTransactionNumber": "0.0",
                    "startDate": "string",
                    "status": "string"
                }
            }
        },
        "securitySchemes": {
            "apiKeyHeader": {
                "type": "apiKey",
                "name": "Ocp-Apim-Subscription-Key",
                "in": "header"
            },
            "apiKeyQuery": {
                "type": "apiKey",
                "name": "subscription-key",
                "in": "query"
            }
        }
    },
    "security": [{
        "apiKeyHeader": []
    }, {
        "apiKeyQuery": []
    }]
}