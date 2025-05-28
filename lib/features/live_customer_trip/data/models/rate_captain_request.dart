class RateCaptainRequest {
  int id;
  double rate;

  RateCaptainRequest(this.id, this.rate);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'rate': rate,
    };
  }
}
