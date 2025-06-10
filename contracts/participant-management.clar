;; Participant Management Contract
;; Manages demand response program participants

(define-map participants
  { participant-id: uint }
  {
    address: principal,
    name: (string-ascii 100),
    energy-capacity: uint,
    active: bool,
    registration-date: uint
  }
)

(define-map participant-by-address
  { address: principal }
  { participant-id: uint }
)

(define-data-var next-participant-id uint u1)
(define-data-var contract-owner principal tx-sender)

;; Register a new participant
(define-public (register-participant (name (string-ascii 100)) (energy-capacity uint))
  (let ((participant-id (var-get next-participant-id)))
    (asserts! (is-none (map-get? participant-by-address { address: tx-sender })) (err u409))
    (asserts! (> energy-capacity u0) (err u400))

    (map-set participants
      { participant-id: participant-id }
      {
        address: tx-sender,
        name: name,
        energy-capacity: energy-capacity,
        active: true,
        registration-date: block-height
      }
    )

    (map-set participant-by-address
      { address: tx-sender }
      { participant-id: participant-id }
    )

    (var-set next-participant-id (+ participant-id u1))
    (ok participant-id)
  )
)

;; Update participant status
(define-public (update-participant-status (participant-id uint) (active bool))
  (let ((participant (unwrap! (map-get? participants { participant-id: participant-id }) (err u404))))
    (asserts! (is-eq tx-sender (get address participant)) (err u401))

    (map-set participants
      { participant-id: participant-id }
      (merge participant { active: active })
    )
    (ok true)
  )
)

;; Get participant info
(define-read-only (get-participant (participant-id uint))
  (map-get? participants { participant-id: participant-id })
)

;; Get participant by address
(define-read-only (get-participant-by-address (address principal))
  (match (map-get? participant-by-address { address: address })
    participant-info (map-get? participants { participant-id: (get participant-id participant-info) })
    none
  )
)

;; Check if participant is active
(define-read-only (is-participant-active (address principal))
  (match (get-participant-by-address address)
    participant (get active participant)
    false
  )
)
