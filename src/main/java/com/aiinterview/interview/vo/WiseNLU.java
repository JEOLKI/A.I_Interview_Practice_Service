package com.aiinterview.interview.vo;

public class WiseNLU {
	static public class Morpheme {
		public final String text;
		public final String type;
		public Integer count;

		public Morpheme(String text, String type, Integer count) {
			this.text = text;
			this.type = type;
			this.count = count;
		}
	}

	static public class NameEntity {
		public final String text;
		public final String type;
		public Integer count;

		public NameEntity(String text, String type, Integer count) {
			this.text = text;
			this.type = type;
			this.count = count;
		}
	}
}
