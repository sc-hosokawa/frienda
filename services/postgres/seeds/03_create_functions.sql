-- plays_daily テーブルのトリガー
CREATE OR REPLACE FUNCTION update_plays_daily_sum()
RETURNS TRIGGER AS $$
BEGIN
  NEW.sum := NEW.spotify + NEW.apple + NEW.line + NEW.amazon + NEW.youtube;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_plays_daily_sum_trigger
BEFORE INSERT OR UPDATE ON plays_daily
FOR EACH ROW EXECUTE FUNCTION update_plays_daily_sum();

-- plays_monthly テーブルのトリガー
CREATE OR REPLACE FUNCTION update_plays_monthly_sum()
RETURNS TRIGGER AS $$
BEGIN
  NEW.sum := NEW.spotify + NEW.apple + NEW.line + NEW.amazon + NEW.youtube;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_plays_monthly_sum_trigger
BEFORE INSERT OR UPDATE ON plays_monthly
FOR EACH ROW EXECUTE FUNCTION update_plays_monthly_sum();

-- plays_yearly テーブルのトリガー
CREATE OR REPLACE FUNCTION update_plays_yearly_sum()
RETURNS TRIGGER AS $$
BEGIN
  NEW.sum := NEW.spotify + NEW.apple + NEW.line + NEW.amazon + NEW.youtube;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_plays_yearly_sum_trigger
BEFORE INSERT OR UPDATE ON plays_yearly
FOR EACH ROW EXECUTE FUNCTION update_plays_yearly_sum();