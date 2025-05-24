package model

func (s *StoneData) ToModel() Stone {
	return Stone{
		Color: Color(*(s.Color)),
		X:     *s.X,
		Y:     *s.Y,
		Hash:  0,
	}
}

func (s *Stone) ToData() StoneData {
	color := int(s.Color)
	return StoneData{
		Color: &color,
		X:     &s.X,
		Y:     &s.Y,
	}
}

func (s *JosekiData) ToModel() Joseki {
	var stones []Stone
	for _, stone := range s.Stones {
		stones = append(stones, stone.ToModel())
	}
	return Joseki{
		Stones: stones,
	}
}

func (s *Joseki) ToData() JosekiData {
	var stones []StoneData
	for _, stone := range s.Stones {
		stones = append(stones, stone.ToData())
	}
	return JosekiData{
		Stones: stones,
	}
}

func (s *VideoData) ToModel() Video {
	return Video{
		Id: s.Id,
	}
}

func (s *Video) ToData() VideoData {
	return VideoData{
		Id: s.Id,
	}
}
