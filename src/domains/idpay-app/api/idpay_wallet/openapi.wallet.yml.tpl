openapi: 3.0.1
info:
  title: IDPAY Wallet IO API v2
  description: IDPAY Wallet IO
  version: '2.0'
servers:
  - url: https://api-io.dev.cstar.pagopa.it/idpay/wallet
paths:
  /:
    get:
      tags:
        - wallet
      summary: Returns the list of active initiatives of a citizen
      operationId: getWallet
      parameters:
        - name: Accept-Language
          in: header
          schema:
            type: string
            example: it-IT
            default: it-IT
          required: true
      responses:
        '200':
          description: Ok
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WalletDTO'
              example:
                initiativeList:
                  - initiativeId: string
                    initiativeName: string
                    status: NOT_REFUNDABLE_ONLY_IBAN
                    endDate: string
                    amount: 0.01
                    accrued: 0.01
                    refunded: 0.01
                    iban: string
                    nInstr: 0
        '401':
          description: Authentication failed
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '429':
          description: Too many Request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '500':
          description: Server ERROR
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
  '/{initiativeId}':
    get:
      tags:
        - wallet
      summary: Returns the detail of an active initiative of a citizen
      operationId: getWalletDetail
      parameters:
        - name: Accept-Language
          in: header
          schema:
            type: string
            example: it-IT
            default: it-IT
          required: true
        - name: initiativeId
          in: path
          description: The initiative ID
          required: true
          schema:
            type: string
      responses:
        '200':
          description: Ok
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/InitiativeDTO'
              example:
                initiativeId: string
                initiativeName: string
                status: NOT_REFUNDABLE_ONLY_IBAN
                endDate: string
                amount: 0.01
                accrued: 0.01
                refunded: 0.01
                iban: string
                nInstr: 0
        '401':
          description: Authentication failed
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '404':
          description: The requested ID was not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '429':
          description: Too many Request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '500':
          description: Server ERROR
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
  /{initiativeId}/iban:
    put:
      tags:
        - wallet
      summary: Association of an IBAN to an initiative
      operationId: enrollIban
      parameters:
        - name: Accept-Language
          in: header
          schema:
            type: string
            example: it-IT
            default: it-IT
          required: true
        - name: initiativeId
          in: path
          description: The initiative ID
          required: true
          schema:
            type: string
      requestBody:
        description: 'Unique identifier of the subscribed initiative, IBAN of the citizen'
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/IbanPutDTO'
            example:
              iban: string
              description: string
      responses:
        '200':
          description: Enrollment OK
          content:
            application/json: { }
        '400':
          description: Bad request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '401':
          description: Authentication failed
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '403':
          description: Forbidden
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '404':
          description: The requested ID was not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '429':
          description: Too many Request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '500':
          description: Server ERROR
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
  /{initiativeId}/instruments/{idWallet}:
    put:
      tags:
        - wallet
      summary: Association of a payment instrument to an initiative
      operationId: enrollInstrument
      parameters:
        - name: Accept-Language
          in: header
          schema:
            type: string
            example: it-IT
            default: it-IT
          required: true
        - name: initiativeId
          in: path
          description: The initiative ID
          required: true
          schema:
            type: string
        - name: idWallet
          in: path
          description: A unique id that identifies a payment method
          required: true
          schema:
            type: string
      responses:
        '200':
          description: Enrollment OK
          content:
            application/json: { }
        '400':
          description: Bad request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '401':
          description: Authentication failed
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '403':
          description: Forbidden
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '404':
          description: The requested ID was not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '429':
          description: Too many Request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '500':
          description: Server ERROR
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
  /{initiativeId}/instruments:
    get:
      tags:
        - wallet
      summary: Returns the list of payment instruments associated to the initiative by the citizen
      operationId: getInstrumentList
      parameters:
        - name: Accept-Language
          in: header
          schema:
            type: string
            example: it-IT
            default: it-IT
          required: true
        - name: initiativeId
          in: path
          description: The initiative ID
          required: true
          schema:
            type: string
      responses:
        '200':
          description: Ok
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/InstrumentListDTO'
        '401':
          description: Authentication failed
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '404':
          description: The requested ID was not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '429':
          description: Too many Request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '500':
          description: Server ERROR
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string

  /{initiativeId}/instruments/{instrumentId}:
    delete:
      tags:
        - wallet
      summary: Delete a payment instrument from an initiative
      operationId: deleteInstrument
      parameters:
        - name: Accept-Language
          in: header
          schema:
            type: string
            example: it-IT
            default: it-IT
          required: true
        - name: initiativeId
          in: path
          description: The initiative ID
          required: true
          schema:
            type: string
        - name: instrumentId
          in: path
          description: A unique id, internally detached, which identifies a payment method
          required: true
          schema:
            type: string
      responses:
        '200':
          description: Delete OK
          content:
            application/json: { }
        '400':
          description: Bad request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '401':
          description: Authentication failed
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '403':
          description: Forbidden
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '404':
          description: The requested ID was not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '429':
          description: Too many Request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '500':
          description: Server ERROR
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string

  /{initiativeId}/unsubscribe:
    delete:
      tags:
        - wallet
      summary: Unsubscribe to an initiative
      operationId: unsubscribe
      parameters:
        - name: Accept-Language
          in: header
          schema:
            type: string
            example: it-IT
            default: it-IT
          required: true
        - name: initiativeId
          in: path
          description: The initiative ID
          required: true
          schema:
            type: string
      responses:
        '200':
          description: Unsubscribe OK
          content:
            application/json: { }
        '400':
          description: Bad request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '401':
          description: Authentication failed
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '403':
          description: Forbidden
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '404':
          description: The requested ID was not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '429':
          description: Too many Request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '500':
          description: Server ERROR
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string

  '/{initiativeId}/status':
    get:
      tags:
        - wallet
      summary: Returns the actual wallet status
      operationId: getWalletStatus
      parameters:
        - name: Accept-Language
          in: header
          schema:
            type: string
            example: it-IT
            default: it-IT
          required: true
        - name: initiativeId
          in: path
          description: The initiative ID
          required: true
          schema:
            type: string
      responses:
        '200':
          description: Check successful
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/WalletStatusDTO'
              example:
                status: NOT_REFUNDABLE_ONLY_IBAN
        '400':
          description: Bad Request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '401':
          description: Authentication failed
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '404':
          description: The requested ID was not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '429':
          description: Too many Request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
        '500':
          description: Server ERROR
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorDTO'
              example:
                code: 0
                message: string
components:
  schemas:
    IbanPutDTO:
      title: IbanPutDTO
      type: object
      required:
        - iban
        - description
      properties:
        iban:
          type: string
          description: IBAN of the citizen
        description:
          type: string
          description: further information about the iban
    WalletStatusDTO:
      title: WalletStatusDTO
      type: object
      required:
        - status
      properties:
        status:
          enum:
            - NOT_REFUNDABLE_ONLY_IBAN
            - NOT_REFUNDABLE_ONLY_INSTRUMENT
            - REFUNDABLE
            - NOT_REFUNDABLE
            - UNSUBSCRIBED
          type: string
          description: actual status of the citizen wallet for an initiative
    WalletDTO:
      type: object
      required:
        - initiativeList
      properties:
        initiativeList:
          type: array
          items:
            $ref: '#/components/schemas/InitiativeDTO'
          description: The list of active initiatives of a citizen
    InstrumentListDTO:
      type: object
      required:
        - instrumentList
      properties:
        instrumentList:
          type: array
          items:
            $ref: '#/components/schemas/InstrumentDTO'
          description: The list of payment instruments associated to the initiative by the citizen
    InstrumentDTO:
      title: InstrumentDTO
      type: object
      required:
        - instrumentId
      properties:
        idWallet:
          type: string
          description: Wallet's id provided by the Payment manager
        instrumentId:
          type: string
          description: Payment instrument id
        maskedPan:
          type: string
          description: Masked Pan
        channel:
          type: string
        brandLogo:
          type: string
          description: Card's brand as mastercard, visa, ecc.
        brand:
          type: string
        status:
          enum:
            - ACTIVE
            - PENDING_ENROLLMENT_REQUEST
            - PENDING_DEACTIVATION_REQUEST
          type: string
          description: The status of the instrument
    InitiativeDTO:
      type: object
      required:
        - initiativeId
        - status
        - endDate
        - nInstr
      properties:
        initiativeId:
          type: string
        initiativeName:
          type: string
        status:
          enum:
            - NOT_REFUNDABLE_ONLY_IBAN
            - NOT_REFUNDABLE_ONLY_INSTRUMENT
            - REFUNDABLE
            - NOT_REFUNDABLE
            - UNSUBSCRIBED
          type: string
        endDate:
          type: string
          format: date
        amount:
          type: number
        accrued:
          type: number
        refunded:
          type: number
        iban:
          type: string
        nInstr:
          type: integer
          format: int32
    ErrorDTO:
      type: object
      required:
        - code
        - message
      properties:
        code:
          type: integer
          format: int32
        message:
          type: string
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
security:
  - bearerAuth: [ ]
tags:
  - name: wallet
    description: ''
