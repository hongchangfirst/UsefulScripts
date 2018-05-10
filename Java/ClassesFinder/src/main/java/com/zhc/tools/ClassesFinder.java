package com.zhc.tools;

import java.util.Set;

import org.reflections.Reflections;

/**
 * Find all classes or interfaces that extends or implements a super type.
 * Author: Hongchang
 */
public class ClassesFinder {
    /**
     * args[0] is the class or interface name such as com.zhc.services.VerificationService
     * @param args
     * @throws Exception
     */
    public static void main(String[] args) throws Exception {
        if (args.length < 1) {
            System.err.println("Error: please add the class or interface name.");
            System.exit(1);
        }

        System.out.println("Finding " + args[0]);
        Class clazz = Class.forName(args[0]);

        Reflections reflections = new Reflections(".*");
        Set<Class> subClasses = reflections.getSubTypesOf(clazz);

        System.out.printf("Find %d classes.\n", subClasses.size());
        for (Class c : subClasses) {
            System.out.println(c.getCanonicalName());
        }
    }
}