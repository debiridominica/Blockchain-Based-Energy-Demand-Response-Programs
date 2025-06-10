;; Demand Response Contract
;; Manages demand response events and participation

(define-map demand-events
  { event-id: uint }
  {
    utility-id: uint,
    start-time: uint,
    end-time: uint,
    target-reduction: uint,
    incentive-rate: uint,
    active: bool
  }
)

(define-map event-participation
  { event-id: uint, participant-id: uint }
  {
    committed-reduction: uint,
    actual-reduction: uint,
    participation-time: uint
  }
)

(define-data-var next-event-id uint u1)

;; Create a new demand response event
(define-public (create-demand-event
  (utility-id uint)
  (start-time uint)
  (end-time uint)
  (target-reduction uint)
  (incentive-rate uint))
  (let ((event-id (var-get next-event-id)))
    ;; Verify utility exists and is verified (simplified check)
    (asserts! (> utility-id u0) (err u400))
    (asserts! (> end-time start-time) (err u400))
    (asserts! (> target-reduction u0) (err u400))
    (asserts! (> incentive-rate u0) (err u400))

    (map-set demand-events
      { event-id: event-id }
      {
        utility-id: utility-id,
        start-time: start-time,
        end-time: end-time,
        target-reduction: target-reduction,
        incentive-rate: incentive-rate,
        active: true
      }
    )

    (var-set next-event-id (+ event-id u1))
    (ok event-id)
  )
)

;; Participate in a demand response event
(define-public (participate-in-event (event-id uint) (participant-id uint) (committed-reduction uint))
  (let ((event (unwrap! (map-get? demand-events { event-id: event-id }) (err u404))))
    (asserts! (get active event) (err u400))
    (asserts! (> committed-reduction u0) (err u400))
    (asserts! (<= committed-reduction (get target-reduction event)) (err u400))

    (map-set event-participation
      { event-id: event-id, participant-id: participant-id }
      {
        committed-reduction: committed-reduction,
        actual-reduction: u0,
        participation-time: block-height
      }
    )
    (ok true)
  )
)

;; Record actual energy reduction
(define-public (record-actual-reduction (event-id uint) (participant-id uint) (actual-reduction uint))
  (let ((participation (unwrap! (map-get? event-participation { event-id: event-id, participant-id: participant-id }) (err u404))))
    (asserts! (<= actual-reduction (get committed-reduction participation)) (err u400))

    (map-set event-participation
      { event-id: event-id, participant-id: participant-id }
      (merge participation { actual-reduction: actual-reduction })
    )
    (ok true)
  )
)

;; Get demand event info
(define-read-only (get-demand-event (event-id uint))
  (map-get? demand-events { event-id: event-id })
)

;; Get participation info
(define-read-only (get-participation (event-id uint) (participant-id uint))
  (map-get? event-participation { event-id: event-id, participant-id: participant-id })
)
